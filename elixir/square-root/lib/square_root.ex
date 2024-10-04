defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand), do: radix(radicand, 1, radicand)

  defp radix(aim, bot, top) do
    middle = (bot + top) / 2
    square = middle * middle

    cond do
      square == aim -> middle
      square > aim -> radix(aim, bot, middle)
      square < aim -> radix(aim, middle, top)
    end
  end
end
