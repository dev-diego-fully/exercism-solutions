defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    divisible_for(limit, factors)
    |> Enum.reduce(0, &+/2)
  end

  defp divisible_for(limit, factors) do
    1..(limit-1)
    |> Enum.filter(fn x -> divisible_by_any?(x, factors) end)
  end

  defp divisible_by_any?(number, factors) do
    Enum.any?(factors, fn x -> disivisible?(number, x) end)
  end

  defp disivisible?(x, y) do
    y != 0 and rem(x, y) == 0 or x == 0
  end
end
