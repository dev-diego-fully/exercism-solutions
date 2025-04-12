defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(anagram_checker(base))
  end

  # Returns a closure that checks whether a given string is an anagram
  # of the string used to construct this closure.
  @spec anagram_checker(String.t()) :: (String.t() -> boolean)
  defp anagram_checker(base) do
    lowered_base = String.downcase(base)
    base_chars = sorted_chars(lowered_base)

    fn str ->
      lowered = String.downcase(str)
      lowered != lowered_base && sorted_chars(lowered) == base_chars
    end
  end

  # Returns a copy of the given string with all its characters sorted.
  @spec sorted_chars(String.t()) :: charlist()
  defp sorted_chars(string) do
    string
    |> String.to_charlist()
    |> Enum.sort()
  end
end
