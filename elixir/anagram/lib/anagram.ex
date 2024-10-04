defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_chars = characteres(base)
    lower_base = String.downcase(base)
    anagram_of_base? = fn s ->
      String.downcase(s) != lower_base and characteres(s) == base_chars
    end
    candidates
    |> Enum.filter(anagram_of_base?)
  end

  defp characteres(string) do
    string
    |> String.downcase()
    |> String.split("")
    |> Enum.sort()
  end
end
