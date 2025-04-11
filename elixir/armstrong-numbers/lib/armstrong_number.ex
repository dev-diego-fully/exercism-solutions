defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """
  @spec valid?(integer) :: boolean
  def valid?(number) do
    armstrong_sum(number) == number
  end

  #  Calculates the sum of each digit of a given number raised
  # by the number of digits the number has. Used to check whether
  # a number is an Armstrong number or not.
  @spec armstrong_sum(integer) :: integer
  defp armstrong_sum(number) do
    digits = Integer.digits(number)
    powerate_digit = digits
    |> length()
    |> armstrong_digit_powerator()

    digits
    |> Stream.map(powerate_digit)
    |> Enum.sum()
  end

  # Returns a closure that raises the number given to it
  # by the number used to construct it.
  @spec armstrong_digit_powerator(integer) :: integer
  defp armstrong_digit_powerator(digits_count) do
    fn digit ->
      digit ** digits_count
    end
  end

end
