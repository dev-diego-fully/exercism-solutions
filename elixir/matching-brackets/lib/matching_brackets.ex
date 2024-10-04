defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r/[^\{\(\[\]\)\}]/, "")
    |> String.split("")
    |> Enum.reject(fn c -> c == "" end)
    |> do_check()
  end

  @spec do_check(list(String.t()), list(String.t())) :: boolean()
  defp do_check(original, processed \\ [])

  defp do_check([], []), do: true

  defp do_check(["{" | tail], processed), do: do_check(tail, ["{" | processed])
  defp do_check(["(" | tail], processed), do: do_check(tail, ["(" | processed])
  defp do_check(["[" | tail], processed), do: do_check(tail, ["[" | processed])
  defp do_check(["}" | o_tail], ["{" | p_tail]), do: do_check(o_tail, p_tail)
  defp do_check(["]" | o_tail], ["[" | p_tail]), do: do_check(o_tail, p_tail)
  defp do_check([")" | o_tail], ["(" | p_tail]), do: do_check(o_tail, p_tail)

  defp do_check(_, _), do: false
end
