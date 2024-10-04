defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when not is_integer(number) or number <= 0,
    do: error("Classification is only possible for natural numbers.")

  def classify(number) do
    aliquote_sum(number)
    |> type(number)
    |> ok()
  end

  defp type(_, 1), do: :deficient
  defp type(number, number), do: :perfect
  defp type(sum, number) when sum > number, do: :abundant
  defp type(sum, number) when sum < number, do: :deficient

  defp aliquote_sum(number) do
    1..ceil(number / 2)
    |> Enum.filter(fn x -> rem(number, x) == 0 end)
    |> Enum.reduce(0, fn x, sum -> sum + x end)
  end

  defp ok(value) do
    {:ok, value}
  end

  defp error(reason) do
    {:error, reason}
  end
end
