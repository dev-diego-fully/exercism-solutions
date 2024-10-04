defmodule RomanNumerals do

  @roman_digits %{
    1 => ["I", "X", "C", "M"],
    5 => ["V", "L", "D"]
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> Integer.digits()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {x, p} -> value(x, p) end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp value(arabic_digit, position) when arabic_digit in [1, 5],
    do: @roman_digits[arabic_digit] |> Enum.at(position)

  defp value(2, position) do
    one = value(1, position)
    "#{one}#{one}"
  end

  defp value(3, position) do
    one = value(1, position)
    "#{one}#{one}#{one}"
  end

  defp value(4, position) do
    [one, five] = [value(1, position), value(5, position)]
    "#{one}#{five}"
  end

  defp value(6, position) do
    [one, five] = [value(1, position), value(5, position)]
    "#{five}#{one}"
  end

  defp value(7, position) do
    [one, five] = [value(1, position), value(5, position)]
    "#{five}#{one}#{one}"
  end

  defp value(8, position) do
    [one, five] = [value(1, position), value(5, position)]
    "#{five}#{one}#{one}#{one}"
  end

  defp value(9, position) do
    [one, ten] = [value(1, position), value(1, position + 1)]
    "#{one}#{ten}"
  end

  defp value(0, _), do: ""
end
