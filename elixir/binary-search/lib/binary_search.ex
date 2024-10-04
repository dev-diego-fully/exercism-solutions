defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    do_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  @spec do_search(tuple, integer, non_neg_integer, non_neg_integer) :: {:ok, integer} | :not_found
  defp do_search(_, _, bot, top) when bot > top, do: :not_found
  defp do_search(_, _, bot, top) when top < bot, do: :not_found

  defp do_search(numbers, key, bot, top) do
    middle = floor((bot + top) / 2)
    current = elem(numbers, middle)

    cond do
      current == key -> {:ok, middle}
      current < key -> do_search(numbers, key, bot + 1, top)
      true -> do_search(numbers, key, bot, top - 1)
    end
  end
end
