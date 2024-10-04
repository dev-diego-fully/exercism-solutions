defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  @spec compare(List.t(), List.t()) :: :equal | :unequal | :sublist | :superlist
  def compare(a, b)

  def compare(a, b) when a === b, do: :equal

  def compare(a, b) do
    cond do
      a |> sublist?(b) -> :sublist
      b |> sublist?(a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?(a, b) when length(b) < length(a), do: false

  defp sublist?(a, b) do
    slice_size = length(a)
    limit = length(b) - slice_size
    0..limit
    |> Enum.map(fn n -> {n, n + slice_size} end)
    |> Enum.any?(
    fn {s, e} ->
      b
      |> Enum.slice(s, e)
      |> Enum.zip(a)
      |> Enum.all?(fn {a,b} -> a === b end) end)
  end

end
