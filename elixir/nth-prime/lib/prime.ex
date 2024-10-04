defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count),
    do: count |> primes_count |> primes_at |> Enum.at(count - 1)

  @spec primes_count(non_neg_integer()) :: non_neg_integer
  defp primes_count(at) do
    ceil(at * :math.log(at) * (1.01 + max(20 - :math.log10(at), 0)/100))
  end

  @spec primes_at(non_neg_integer()) :: non_neg_integer
  defp primes_at(number) do
    do_primes_at(candidates_at(number), 0)
  end

  @spec do_primes_at([non_neg_integer()], non_neg_integer) :: non_neg_integer
  defp do_primes_at(candidates, current) when is_list(candidates) do
    if current >= length(candidates) do
      candidates
    else
      factor = Enum.at(candidates, current)
      do_primes_at(
        Enum.reject(candidates, fn n -> n != factor and rem(n, factor) == 0 end),
        current + 1
      )
    end
  end

  @spec candidates_at(non_neg_integer) :: [non_neg_integer]
  defp candidates_at(number) do
    Enum.concat([2], Enum.to_list(3..number+1//2))
  end

end
