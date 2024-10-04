defmodule House do
  @objects_and_action_suffered [
    {"house that Jack built.", "lay in"},
    {"malt", "ate"},
    {"rat", "killed"},
    {"cat", "worried"},
    {"dog", "tossed"},
    {"cow with the crumpled horn", "milked"},
    {"maiden all forlorn", "kissed"},
    {"man all tattered and torn", "married"},
    {"priest all shaven and shorn", "woke"},
    {"rooster that crowed in the morn", "kept"},
    {"farmer sowing his corn", "belonged to"},
    {"horse and the hound and the horn", ""}
  ]

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    "#{start..stop |> Enum.map(&generate_verse/1) |> Enum.join("\n")}\n"
  end

  @spec generate_verse(non_neg_integer()) :: String.t()
  defp generate_verse(verse_number) do
    1..verse_number
    |> Enum.map(fn line -> generate_line(line, verse_number) end)
    |> Enum.join(" ")
  end

  @spec generate_line(non_neg_integer(), non_neg_integer()) :: String.t()
  defp generate_line(line_number, verse_number)

  defp generate_line(1, verse_number),
    do: (verse_number - 1) |> get_object() |> this_is()

  defp generate_line(line_number, verse_number) do
    {object, action} =
      @objects_and_action_suffered
      |> Enum.at(verse_number - line_number)

    that_do_to(action, object)
  end

  @spec this_is(String.t()) :: String.t()
  defp this_is(object),
    do: "This is the #{object}"

  @spec that_do_to(Strint.t(), Strint.t()) :: String.t()
  defp that_do_to(action, subject),
    do: "that #{action} the #{subject}"

  @spec get_object(String.t()) :: String.t()
  defp get_object(line) do
    {object, _} = @objects_and_action_suffered |> Enum.at(line)
    object
  end
end
