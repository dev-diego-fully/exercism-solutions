defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    if number |> String.match?(~r/[^\d\s]/) do
      false
    else
      digits = number |> digits()

      if length(digits) <= 1 do
        false
      else
        digits
        |> luhn_for()
        |> Enum.sum()
        |> rem(10) == 0
      end
    end
  end

  defp luhn_for(digits) do
    [last | rest] = digits |> Enum.reverse()

    [last | rest |> Enum.map_every(2, &double_digit/1)]
    |> Enum.reverse()
  end

  defp digits(str) do
    str
    |> String.replace(~r/\D/, "")
    |> String.split("")
    |> (&--/2).(["", ""])
    |> Enum.map(&String.to_integer/1)
  end

  defp double_digit(d) when d * 2 > 9, do: d * 2 - 9
  defp double_digit(d), do: d * 2
end
