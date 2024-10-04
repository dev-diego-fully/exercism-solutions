defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base)

  def convert(_, input_base, _) when input_base < 2,
    do: {:error, "input base must be >= 2"}

  def convert(_, _, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, same_base, same_base),
    do: {:ok, digits}

  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, fn d -> d < 0 or d >= input_base end) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {:ok,
       value_of(digits, input_base)
       |> convert_number(output_base)}
    end
  end

  defp value_of(digits, base) do
    Enum.zip((length(digits) - 1)..0, digits)
    |> Enum.map(fn {k, d} -> digit_value(d, base, k) end)
    |> Enum.reduce(&+/2)
  end

  defp convert_number(number, base, digits \\ [])

  defp convert_number(0, _, []), do: [0]

  defp convert_number(0, _, digits), do: digits

  defp convert_number(number, base, digits),
    do: convert_number(floor(number / base), base, [rem(number, base) | digits])

  defp digit_value(digit, base, position),
    do: digit * Integer.pow(base, position)
end
