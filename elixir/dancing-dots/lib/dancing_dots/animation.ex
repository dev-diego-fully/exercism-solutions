defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot :: dot, frame_number :: number, opts :: opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{opacity: opacity} = dot, frame, _)
      when rem(frame, 4) == 0 do
    %DancingDots.Dot{dot | opacity: opacity * 0.5}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init([]) do
    {:error,
     "The :velocity option is required, and its value must be a number. Got: #{inspect(nil)}"}
  end

  @impl DancingDots.Animation
  def init(velocity: velocity) when not is_number(velocity) do
    {:error,
     "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
  end

  @impl DancingDots.Animation
  def init(velocity: velocity) do
    {:ok, [velocity: velocity]}
  end

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{radius: r} = dot, frame, velocity: v) do
    %DancingDots.Dot{ dot | radius: r + v * (frame - 1)  }
  end
end
