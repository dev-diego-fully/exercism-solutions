defmodule Prime do
  @initial_primes [2, 3]

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count)

  # Invalid ordinality: less than 1.
  def nth(count) when count <= 0,
    do: raise(ArgumentError)

  # Initializes the do_nth function, which effectively searches for the
  # nth prime.
  def nth(count),
    do: do_nth(count, @initial_primes, 0)

  # Find the Nth prime number recursively using TCO
  @spec do_nth(non_neg_integer, [non_neg_integer], non_neg_integer) :: non_neg_integer
  defp do_nth(target, primes, current_index)

  # Base case: the nth prime number has already been recorded in the list of primes.
  defp do_nth(target, primes, _) when length(primes) >= target,
    do: primes |> Enum.at(target - 1)

  # Main case: The nth prime has not been found yet and the list needs to
  # be updated with more primes.
  defp do_nth(target, primes, current_index),
    do: do_nth(target, more_primes(primes, current_index), current_index + 1)

  # Given a current index, find new primes that can be found using primes
  # that are less than or equal to the prime at that index.
  @spec more_primes([non_neg_integer], non_neg_integer) :: [non_neg_integer]
  defp more_primes(primes, prime_index) do
    current_prime = primes |> Enum.at(prime_index)
    next_prime = primes |> Enum.at(prime_index + 1)

    min = current_prime * current_prime
    max = next_prime * next_prime - 1

    primes
    |> Stream.take(prime_index + 1)
    |> Enum.reduce(min..max, &remove_multiples(&2, &1))
    |> then(fn new -> Enum.concat(primes, new) end)
  end

  # Removes from the given list, the numbers that are multiples of the given
  # factor.
  @spec remove_multiples([{non_neg_integer, boolean}], non_neg_integer) ::
          Stream.t(non_neg_integer)
  defp remove_multiples(list, factor),
    do: Stream.reject(list, fn n -> rem(n, factor) == 0 end)
end
