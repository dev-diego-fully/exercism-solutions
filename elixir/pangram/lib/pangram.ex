defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @alphabet [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "n",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ]

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence_letters =
      sentence
      |> String.downcase()
      |> String.replace(~r/[^a-z]/, "")
      |> String.split("")
      |> Enum.reject(fn x -> x == "" end)

    @alphabet
    |> Enum.all?(fn letter -> letter in sentence_letters end)
  end
end
