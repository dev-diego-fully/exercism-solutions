defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.map(fn {key, value} ->
      value
      |> Enum.map(fn elem -> {key, elem} end)
    end
    )
    |> List.flatten()
    |> Enum.map(fn {key, value} -> {String.downcase(value), key} end)
    |> Map.new
  end
end
