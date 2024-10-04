defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit) do
    2..limit
    |> sieve(limit)
  end

  @spec sieve([non_neg_integer], non_neg_integer, non_neg_integer) :: [non_neg_integer]
  defp sieve(number, limit, index \\ 0)

  defp sieve(numbers, _, index) when index >= length(numbers),
    do: numbers

  defp sieve(numbers, limit, index) do
    current = numbers |> Enum.at(index)
    multiplies = current*2..limit//current

    numbers
    |> Enum.reject(fn x -> x in multiplies end)
    |> sieve(limit, index + 1)
  end
end
