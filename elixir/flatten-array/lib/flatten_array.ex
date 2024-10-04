defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    if list |> Enum.any?(&is_list/1) do
      list
      |> List.flatten()
      |> flatten()
    else
      list
      |> Enum.reject(&is_nil/1)
    end
  end
end
