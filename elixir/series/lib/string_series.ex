defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size)

  def slices(_, size) when size <= 0,
    do: []

  def slices(s, size) do
    if size > String.length(s) do
      []
    else
      string_limit = String.length(s) - size
      0..string_limit
      |> Enum.map(fn n -> String.slice(s, n, size) end)
    end
  end
end
