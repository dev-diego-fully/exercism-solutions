defmodule Say do
  @number_group_suffixes ["thousand", "million", "billion"]

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number)

  def in_english(number) when number < 0 or number >= 1.0e12,
    do: {:error, "number is out of range"}

  def in_english(0),
    do: {:ok, "zero"}

  def in_english(number) do
    number
    |> sub_numbers()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(&suffixed_said/1)
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.reverse()
    |> Enum.join(" ")
    |> then(fn x -> {:ok, x} end)
  end

  @spec sub_numbers(non_neg_integer) :: list(non_neg_integer())
  defp sub_numbers(number) do
    number
    |> grouped_digits()
    |> Enum.map(fn x -> x |> Integer.undigits() |> Integer.digits() end)
  end

  defp suffixed_said(pair)

  defp suffixed_said({number, 0}),
    do: "#{said(number)}"

  defp suffixed_said({[0], pos}) when pos != 0,
    do: ""

  defp suffixed_said({number, pos}),
    do: "#{said(number)} #{@number_group_suffixes |> Enum.at(pos - 1)}"

  @spec grouped_digits(integer) :: list(list(non_neg_integer()))
  defp grouped_digits(number) do
    number
    |> Integer.digits()
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.reverse()
    |> Enum.map(&Enum.reverse/1)
  end

  @spec said(list(number())) :: String.t()
  defp said(number)
  defp said([0]), do: ""
  defp said([1]), do: "one"
  defp said([2]), do: "two"
  defp said([3]), do: "three"
  defp said([4]), do: "four"
  defp said([5]), do: "five"
  defp said([6]), do: "six"
  defp said([7]), do: "seven"
  defp said([8]), do: "eight"
  defp said([9]), do: "nine"
  defp said([0, u]), do: said([u])
  defp said([1, 0]), do: "ten"
  defp said([1, 1]), do: "eleven"
  defp said([1, 2]), do: "twelve"
  defp said([1, 3]), do: "thirteen"
  defp said([1, 5]), do: "fifteen"
  defp said([1, 8]), do: "eighteen"
  defp said([1, u]), do: "#{said([u])}teen"
  defp said([2, 0]), do: "twenty"
  defp said([3, 0]), do: "thirty"
  defp said([4, 0]), do: "forty"
  defp said([5, 0]), do: "fifty"
  defp said([6, 0]), do: "sixty"
  defp said([7, 0]), do: "seventy"
  defp said([8, 0]), do: "eighty"
  defp said([9, 0]), do: "ninety"
  defp said([t, u]), do: "#{said([t, 0])}-#{said([u])}"
  defp said([0, t, u]), do: said([t, u])
  defp said([h, 0, 0]), do: "#{said([h])} hundred"
  defp said([h, t, u]), do: "#{said([h, 0, 0])} #{said([t, u])}"
end
