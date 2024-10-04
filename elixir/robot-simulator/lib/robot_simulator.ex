defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _) when direction not in [:north, :east, :south, :west],
    do: {:error, "invalid direction"}

  def create(direction, {x, y}) when is_integer(x) and is_integer(y),
    do: {direction, {x, y}}

  def create(_, _),
    do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    if instructions |> String.match?(~r/[^ARL]/) do
      {:error, "invalid instruction"}
    else
      instructions
      |> String.to_charlist()
      |> Enum.reduce(robot, &execute_action/2)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot)

  def direction({direction, _position}),
    do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot)

  def position({_direction, position}), do: position

  @spec rotate_left(robot()) :: robot()
  defp rotate_left(robot)

  defp rotate_left({:north, position}),
    do: {:west, position}

  defp rotate_left({:west, position}),
    do: {:south, position}

  defp rotate_left({:south, position}),
    do: {:east, position}

  defp rotate_left({:east, position}),
    do: {:north, position}

  @spec rotate_right(robot()) :: robot()
  defp rotate_right(robot)

  defp rotate_right({:north, position}),
    do: {:east, position}

  defp rotate_right({:west, position}),
    do: {:north, position}

  defp rotate_right({:south, position}),
    do: {:west, position}

  defp rotate_right({:east, position}),
    do: {:south, position}

  @spec advance(robot()) :: robot()
  defp advance(robot)

  defp advance({:north, {x, y}}),
    do: {:north, {x, y + 1}}

  defp advance({:east, {x, y}}),
    do: {:east, {x + 1, y}}

  defp advance({:south, {x, y}}),
    do: {:south, {x, y - 1}}

  defp advance({:west, {x, y}}),
    do: {:west, {x - 1, y}}

  @spec execute_action(char(), robot()) :: robot()
  defp execute_action(action, robot)

  defp execute_action(?L, robot),
    do: robot |> rotate_left()

  defp execute_action(?R, robot),
    do: robot |> rotate_right()

  defp execute_action(?A, robot),
    do: robot |> advance()
end
