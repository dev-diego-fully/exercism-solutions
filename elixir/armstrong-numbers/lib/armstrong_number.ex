defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec armstrong_value(integer) :: integer
  defp armstrong_value(number) do
    digits = Integer.digits(number)
    digits_len = length(digits)
    digits
    |>Enum.map(fn x -> x ** digits_len end)
    |> Enum.sum()
  end

  @spec valid?(integer) :: boolean
  def valid?(number) do
    armstrong_value(number) == number
  end

end
