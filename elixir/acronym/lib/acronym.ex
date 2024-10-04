defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) when is_bitstring(string) do
    string
    |> String.replace(~r/[\-\_]/, " ")
    |> String.split(~r/\s/)
    |> Enum.map(fn s -> String.at(s, 0) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(&String.upcase/1)
    |> Enum.join()
  end
end