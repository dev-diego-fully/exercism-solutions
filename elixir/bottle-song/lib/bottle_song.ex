defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @numbers_text %{
    0 => "no",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten"
  }

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    start_bottle..(start_bottle - take_down + 1)
    |> Enum.map(&verse/1)
    |> Enum.join("\n\n")
  end

  defp verse(bottles) do
    number = to_text(bottles)
    next = to_text(bottles - 1)

    {plural_start, plural_rest} = {
      plural_for_hanging(bottles),
      plural_for_lefting(bottles - 1)
    }

    """
    #{number |> String.capitalize()} green bottle#{plural_start} hanging on the wall,
    #{number |> String.capitalize()} green bottle#{plural_start} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{next} green bottle#{plural_rest} hanging on the wall.\
    """
  end

  defp to_text(number), do: @numbers_text[number]
  defp plural_for_hanging(number) when number > 1, do: "s"
  defp plural_for_hanging(_), do: ""
  defp plural_for_lefting(0), do: "s"
  defp plural_for_lefting(number), do: plural_for_hanging(number)
end
