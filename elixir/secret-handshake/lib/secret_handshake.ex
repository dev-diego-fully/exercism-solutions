defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    digits = code |> Integer.digits(2) |> Enum.slice(-5, 5) |> Enum.reverse()
    digits
    |> Enum.with_index()
    |> Enum.filter(fn {d, _} -> d == 1 end)
    |> Enum.map(fn {_, p} -> Integer.pow(2, p) end)
    |> Enum.reduce([], &exec/2)
  end

  @spec exec(command :: integer, state :: list(String.t())) :: list(String.t())
  defp exec(command, state)
  defp exec(1, state), do: Enum.concat(state, ["wink"])
  defp exec(2, state), do: Enum.concat(state, ["double blink"])
  defp exec(4, state), do: Enum.concat(state, ["close your eyes"])
  defp exec(8, state), do: Enum.concat(state, ["jump"])
  defp exec(16, state), do: Enum.reverse(state)
end
