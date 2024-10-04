defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  defp generator(1), do: 2

  defp generator(2), do: 1

  defp generator(n),
    do: generator(n - 1) + generator(n - 2)

  def generate(n) when is_integer(n) and n >= 1,
    do: 1..n |> Stream.map(&generator/1) |> Enum.to_list()

  def generate(_), do:
    raise(ArgumentError, "count must be specified as an integer >= 1")
end
