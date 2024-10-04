defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size)
  def largest_product(_, size) when size < 1, do: raise(ArgumentError)
  def largest_product("", 0), do: 0

  def largest_product(number_string, size) do
    if size > String.length(number_string) do
      raise ArgumentError
    end

    number_string
    |> digits()
    |> series(size)
    |> Enum.map(&Enum.product/1)
    |> Enum.max()
  end

  defp digits(number_string) do
    number_string
    |> String.to_integer()
    |> Integer.digits()
  end

  defp series(digits, serie_size) do
    0..(length(digits) - serie_size)
    |> Enum.map(fn start -> Enum.slice(digits, start, serie_size) end)
  end
end
