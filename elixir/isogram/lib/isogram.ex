defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/[^a-zA-z]/, "")
    |> String.downcase()
    |> String.split("")
    |> Enum.reject(fn c -> c == "" end)
    |> Enum.reduce(%{}, fn x, occurances ->
      Map.update(occurances, x, 1, fn v -> v + 1 end)
    end)
    |> Map.values()
    |> Enum.all?(fn v -> v < 2 end)
  end
end
