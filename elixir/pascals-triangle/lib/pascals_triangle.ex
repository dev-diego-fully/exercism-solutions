defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num)
  def rows(num) when num <= 0, do: []
  def rows(1), do: [[1]]
  def rows(num), do: (num - 1) |> rows() |> add_next_line

  defp add_next_line(triangle) do
    triangle
    |> List.last()
    |> next_line()
    |> then(fn nl -> triangle ++ [nl] end)
  end

  defp next_line(line),
    do: 0..length(line) |> Enum.map(fn i -> value_for(line, i) end)

  defp value_for(line, 0),
    do: line |> Enum.at(0)

  defp value_for(line, index) when index >= length(line),
    do: line |> Enum.at(index - 1)

  defp value_for(line, index),
    do: line |> Enum.slice(index - 1, 2) |> Enum.sum()
end
