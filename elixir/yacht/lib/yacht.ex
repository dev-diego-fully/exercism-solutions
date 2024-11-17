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
  def score(category, dice)

  def score(:ones, dice),
    do: dice |> face_scores(1)

  def score(:twos, dice),
    do: dice |> face_scores(2)

  def score(:threes, dice),
    do: dice |> face_scores(3)

  def score(:fours, dice),
    do: dice |> face_scores(4)

  def score(:fives, dice),
    do: dice |> face_scores(5)

  def score(:sixes, dice),
    do: dice |> face_scores(6)

  def score(:full_house, dice) do
    case Enum.sort(dice) do
      [roll, _, _, _, roll] -> 0
      [lesser, lesser, lesser, greater, greater] -> 3 * lesser + 2 * greater
      [lesser, lesser, greater, greater, greater] -> 2 * lesser + 3 * greater
      _ -> 0
    end
  end

  def score(:four_of_a_kind, dice) do
    case Enum.sort(dice) do
      [roll, roll, roll, roll, _] -> 4 * roll
      [_, roll, roll, roll, roll] -> 4 * roll
      _ -> 0
    end
  end

  def score(:choice, dice),
    do: dice |> Enum.sum()

  def score(:little_straight, dice) do
    case Enum.sort(dice) do
      [1, 2, 3, 4, 5] -> 30
      _ -> 0
    end
  end

  def score(:big_straight, dice) do
    case Enum.sort(dice) do
      [2, 3, 4, 5, 6] -> 30
      _ -> 0
    end
  end

  def score(:yacht, [roll, roll, roll, roll, roll]), do: 50
  def score(:yacht, _), do: 0

  defp face_scores(dice, face),
    do: dice |> face_count(face) |> (&*/2).(face)

  defp face_count(dice, face),
    do: dice |> Enum.count(face_counter(face))

  defp face_counter(face),
    do: fn r -> r == face end
end
