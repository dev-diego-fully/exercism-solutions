defmodule TwelveDays do
  @presents_per_day [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @order [
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth"
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "#{on_day(number)} #{gifts_for(number)}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing,
    do: verses(1, 12)

  @spec gift_for(non_neg_integer()) :: String.t()
  defp gift_for(day_number),
    do: @presents_per_day |> Enum.at(day_number - 1)

  defp gifts_for(1),
    do: gift_for(1)

  defp gifts_for(day_number) do
    previous_gifts = day_number..2 |> Enum.map(&gift_for/1) |> Enum.join(", ")
    "#{previous_gifts}, and #{gift_for(1)}"
  end

  @spec ordenal_for(non_neg_integer()) :: String.t()
  defp ordenal_for(number),
    do: @order |> Enum.at(number - 1)

  @spec on_day(non_neg_integer()) :: String.t()
  defp on_day(number),
    do: "On the #{ordenal_for(number)} day of Christmas my true love gave to me:"
end
