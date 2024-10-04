defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    pattern = ~r/\b[a-zA-Z0-9]+(?:'[a-zA-Z0-9]+)?\b/
    lowered = sentence |> String.downcase() |> String.replace("_", " ")
    pattern
    |> Regex.scan(lowered)
    |> List.flatten()
    |> Enum.reduce(%{}, &count_word/2)
  end

  defp count_word(word, counter) do
    counter
    |> Map.update(word, 1, fn x -> x + 1 end)
  end

end
