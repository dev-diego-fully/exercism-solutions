defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    [3, 5, 7]
    |> Enum.filter(fn x -> rem(number, x) == 0 end)
    |> (fn x -> if length(x) == 0, do: number, else: x end).()
    |> drop()
  end

  defp drop(values)

  defp drop(3), do: "Pling"
  defp drop(5), do: "Plang"
  defp drop(7), do: "Plong"

  defp drop(values) when is_list(values) do
    values |> Enum.map(&drop/1) |> Enum.join()
  end

  defp drop(value), do: to_string(value)
end
