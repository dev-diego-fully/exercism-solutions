defmodule CollatzConjecture do

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc( input ) when is_integer( input ) and input > 0 do
    collatz_loop( input )
  end

  defp collatz_loop( n, steps \\ 0 )

  defp collatz_loop( n, steps ) when n > 1 do
    n |> next_collatz_number |> collatz_loop( steps + 1 )
  end

  defp collatz_loop( _n, steps ) do
    steps
  end

  defp next_collatz_number( n ) when rem( n, 2 ) == 0 do
    div( n, 2 )
  end

  defp next_collatz_number( n ) do
    3 * n + 1
  end

end
