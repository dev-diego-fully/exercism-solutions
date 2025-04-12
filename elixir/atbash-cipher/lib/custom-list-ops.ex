defmodule CustomListOps do
  @moduledoc false

  @doc """
  Inserts a given element into the given list every n elements of the original list. Does not insert in the last block of n elements.

  ## Examples
  iex> CustomListOps.insert_every(~c"0123456789", 3, ' ')
  ~c"012 345 678 9"
  """
  @spec insert_every([any], integer, any) :: [any]
  def insert_every(list, n, element) do
    list
    |> Stream.chunk_every(n)
    |> Stream.with_index()
    |> Enum.flat_map(every_inserter(element))
  end

  # Given a element, returns a closure that inserts this element at
  # the beginning of the list given to it. It does not perform the
  # insertion if the given index of the list is 0.
  @spec every_inserter(any) :: ({[any], integer} -> [any])
  defp every_inserter(element) do
    fn
      {list, 0} -> list
      {list, _} -> [element | list]
    end
  end
end
