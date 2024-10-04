defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    number
    |> :math.sqrt()
    |> floor()
    |> primes_to()
    |> Enum.filter(fn x -> rem(number, x) == 0 end)
    |> then(fn divers -> factorate(number, divers) end)
  end

  defp factorate(number, candidates, factors \\ [])

  defp factorate(number, _, factors) when number <= 1,
    do: factors |> Enum.reverse()

  defp factorate(number, [], factors) when number > 1,
    do: [number | factors] |> Enum.reverse()

  defp factorate(_, [], factors),
    do: factors |> Enum.reverse()

  defp factorate(number, [c | _] = cands, factors) when rem(number, c) == 0,
    do: factorate(div(number, c), cands, [c | factors])

  defp factorate(number, [_ | tail], factors),
    do: factorate(number, tail, factors)

  defp primes_to(number) when number < 2, do: []
  defp primes_to(2), do: [2]
  defp primes_to(3), do: [2, 3]

  defp primes_to(number) do
    previous_primes = number |> :math.sqrt() |> floor() |> primes_to()
    last = previous_primes |> List.last()

    previous_primes
    |> Enum.concat(
      max(last, 3)..number//2
      |> Enum.reject(fn c ->
        previous_primes
        |> Enum.any?(fn p -> rem(c, p) == 0 end)
      end)
    )
  end
end
