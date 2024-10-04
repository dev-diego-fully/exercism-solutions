defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings)

  def recite([]),
    do: ""

  def recite([reason]),
    do: "#{because(reason)}"

  def recite(strings) do
    1..(length(strings) - 1)
    |> Stream.map(fn x -> line(Enum.at(strings, x - 1), Enum.at(strings, x)) end)
    |> Stream.concat([because(Enum.at(strings, 0))])
    |> Enum.join("\n")
  end

  @spec line(String.t(), String.t()) :: String.t()
  defp line(element, previous),
    do: "For want of a #{element} the #{previous} was lost."

  @spec because(String.t()) :: String.t()
  defp because(reason),
    do: "And all for the want of a #{reason}.\n"
end
