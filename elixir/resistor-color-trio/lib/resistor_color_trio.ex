defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors)

  def label([color1, color2, color3 | _]) do
    metric((value(color1) * 10 + value(color2)) * 10 ** value(color3))
  end

  @spec value(color :: [atom]) :: integer
  defp value(color) do
    case color do
      :black -> 0
      :brown -> 1
      :red -> 2
      :orange -> 3
      :yellow -> 4
      :green -> 5
      :blue -> 6
      :violet -> 7
      :grey -> 8
      :white -> 9
    end
  end

  @kilo 1_000
  @mega 1_000_000
  @giga 1_000_000_000
  @tera 1_000_000_000_000

  @spec value(color :: [integer]) :: {integer, :ohms | :kiloohms | :megaohms | :gigaohms}
  defp metric(value)

  defp metric(value) when value < @kilo,
    do: {value, :ohms}

  defp metric(value) when value < @mega,
    do: {value / @kilo, :kiloohms}

  defp metric(value) when value < @giga,
    do: {value / @mega, :megaohms}

  defp metric(value) when value < @tera,
    do: {value / @giga, :gigaohms}
end
