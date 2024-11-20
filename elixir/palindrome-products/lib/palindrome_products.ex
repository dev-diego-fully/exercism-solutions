defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when max_factor < min_factor,
    do: raise(ArgumentError, "The maximum value cannot be less than the minimum value.")

  def generate(max_factor, min_factor) do
    all_unique_multiplies(min_factor, max_factor)
    |> Stream.filter(fn {a, b} -> palindrome?(a * b) end)
    |> Stream.map(fn {a, b} -> {a * b, [a, b]} end)
    |> Enum.reduce(%{}, fn pair, acc -> acc |> add_factor(pair) end)
  end

  @spec combine(integer, Range.t()) :: Stream.t({integer, integer})
  defp combine(a, b),
    do: b |> Stream.map(fn x -> {a, x} end)

  @spec all_unique_multiplies(non_neg_integer, non_neg_integer) :: Stream.acc()
  defp all_unique_multiplies(min_factor, max_factor),
    do: min_factor..max_factor |> Stream.flat_map(fn x -> combine(x, x..max_factor) end)

  @spec palindrome?(integer) :: boolean()
  defp palindrome?(x),
    do: x == x |> Integer.digits() |> Enum.reverse() |> Integer.undigits()

  defp add_factor(number_map, {product, factors}),
    do: number_map |> Map.update(product, [factors], fn l -> l ++ [factors] end)
end
