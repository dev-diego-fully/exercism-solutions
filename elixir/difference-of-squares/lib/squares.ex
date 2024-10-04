defmodule Squares do
  @moduledoc """
  Calculate sum of squares, square of sum, difference between two sums from 1 to a given end number.
  """

  @doc """
  Calculate sum of squares from 1 to a given end number.
  """
  @spec sum_of_squares(pos_integer) :: pos_integer
  def sum_of_squares(number),
    do: 1..number |> Stream.map(fn x -> x ** 2 end) |> Enum.sum()

  @doc """
  Calculate square of sum from 1 to a given end number.
  """
  @spec square_of_sum(pos_integer) :: pos_integer
  def square_of_sum(number),
    do: 1..number |> Enum.sum() |> (&**/2).(2)

  @doc """
  Calculate difference between sum of squares and square of sum from 1 to a given end number.
  """
  @spec difference(pos_integer) :: pos_integer
  def difference(number),
    do: number |> square_of_sum() |> (&-/2).(number |> sum_of_squares())
end
