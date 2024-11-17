defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice),
    do: dice |> Enum.sort() |> then(fn dice -> do_score(category, dice) end)

  defp do_score(:ones, dice),
    do: dice |> face_scores(1)

  defp do_score(:twos, dice),
    do: dice |> face_scores(2)

  defp do_score(:threes, dice),
    do: dice |> face_scores(3)

  defp do_score(:fours, dice),
    do: dice |> face_scores(4)

  defp do_score(:fives, dice),
    do: dice |> face_scores(5)

  defp do_score(:sixes, dice),
    do: dice |> face_scores(6)

  defp do_score(:full_house, [roll, _, _, _, roll]),
    do: 0

  defp do_score(:full_house, [lesser, lesser, lesser, greater, greater]),
    do: 3 * lesser + 2 * greater

  defp do_score(:full_house, [lesser, lesser, greater, greater, greater]),
    do: 2 * lesser + 3 * greater

  defp do_score(:full_house, _),
    do: 0

  defp do_score(:four_of_a_kind, [roll, roll, roll, roll, _]),
    do: 4 * roll

  defp do_score(:four_of_a_kind, [_, roll, roll, roll, roll]),
    do: 4 * roll

  defp do_score(:four_of_a_kind, _),
    do: 0

  defp do_score(:choice, dice),
    do: dice |> Enum.sum()

  defp do_score(:little_straight, [1, 2, 3, 4, 5]),
    do: 30

  defp do_score(:little_straight, _),
    do: 0

  defp do_score(:big_straight, [2, 3, 4, 5, 6]),
    do: 30

  defp do_score(:big_straight, _),
    do: 0

  defp do_score(:yacht, [roll, roll, roll, roll, roll]),
    do: 50

  defp do_score(:yacht, _),
    do: 0

  defp face_scores(dice, face),
    do: dice |> face_count(face) |> (&*/2).(face)

  defp face_count(dice, face),
    do: dice |> Enum.count(face_counter(face))

  defp face_counter(face),
    do: fn r -> r == face end
end
