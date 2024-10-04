defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase()
    |> String.replace(~r/[^a-z]/, "")
    |> String.to_charlist()
    |> Enum.map(&value_of/1)
    |> Enum.sum()
  end

  @spec value_of(list()) :: non_neg_integer
  defp value_of(str) when str in 'aeioulnrst', do: 1
  defp value_of(str) when str in 'dg', do: 2
  defp value_of(str) when str in 'bcmp', do: 3
  defp value_of(str) when str in 'fhvwy', do: 4
  defp value_of(str) when str in 'k', do: 5
  defp value_of(str) when str in 'jx', do: 8
  defp value_of(str) when str in 'qz', do: 10
  defp value_of(_), do: 0
end
