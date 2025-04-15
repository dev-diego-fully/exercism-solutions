defmodule Username do

  @moduledoc """
  Module for handling German emails.
  Provides a function to sanitize a German email.
  This module works with strings in charlist format.
  """

  @latin_letter ?a..?z
  @allowed_symbols [?_]

  @german_replaces %{
    ?ä => ~c"ae",
    ?ö => ~c"oe",
    ?ü => ~c"ue",
    ?ß => ~c"ss"
  }

  @german_characteres Map.keys(@german_replaces)

  @doc """
  Sanitizes the provided email, removing all characters other than lowercase
  letters and underscores (_) and replacing all German letters with the
  appropriate Latin letter set.
  """
  @spec sanitize(charlist()) :: charlist()
  def sanitize(username) do
    username
    |> Stream.filter(&allowed_character?/1)
    |> Enum.flat_map(&replace_germans/1)
  end

  # Returns whether the character is accepted in the email or not.
  # Accepted characters are: lowercase Latin and German
  # letters and underscores (_)
  @spec allowed_character?(integer()) :: boolean()
  defp allowed_character?(char) do
    case char do
      char when char in @latin_letter -> true
      char when char in @allowed_symbols -> true
      char when char in @german_characteres -> true
      _ -> false
    end
  end

  # Replaces German letters with a suitable pair of Latin letters.
  # Everything else is left as is.
  @spec replace_germans(integer()) :: integer()
  defp replace_germans(char) do
    case @german_replaces |> Map.get(char) do
      nil -> [char]
      replaced -> replaced
    end
  end
end
