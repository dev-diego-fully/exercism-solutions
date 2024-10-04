defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when is_bitstring(text) do
    text
    |> String.to_charlist()
    |> rotate(shift)
  end

  def rotate(text, shift) when is_list(text) do
    text
    |> Enum.map(fn c -> rotate(c, shift) end)
    |> List.to_string()
  end

  def rotate(text, shift) when is_integer(text) do
    cond do
      lowercase?(text) -> ?a + rem(text - ?a + shift, 26)
      uppercase?(text) -> ?A + rem(text - ?A + shift, 26)
      true -> text
    end
  end

  defp uppercase?(chr),
    do: ?A <= chr and chr <= ?Z

  defp lowercase?(chr),
    do: ?a <= chr and chr <= ?z
end
