defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string)

  def encode(""), do: ""

  def encode(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce([], fn e, acc -> push_char(acc, e) end)
    |> Enum.map(fn {e, c} -> [e, c] end)
    |> List.flatten()
    |> Enum.reject(fn s -> s == 1 end)
    |> Enum.map(&to_string/1)
    |> Enum.reverse()
    |> Enum.join("")
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    ~r/(\d+|[^\d])/
    |> Regex.scan(string)
    |> Enum.map(fn [x, _] -> x end)
    |> Enum.map(fn x ->
      case Integer.parse(x) do
        :error -> x
        {int, _} -> int
      end
    end)
    |> Enum.reverse()
    |> Enum.reduce(
      [],
      fn x, acc ->
        if not is_integer(x) do
          [%{char: x} | acc]
        else
          [head | tail] = acc
          [Map.put(head, :count, x) | tail]
        end
      end
    )
    |> Enum.map(fn x ->
      char = x |> Map.get(:char)
      count = x |> Map.get(:count, 1)
      String.duplicate(char, count)
    end)
    |> Enum.join("")
  end

  defp push_char(list, char)

  defp push_char([{char, n} | tail], char) do
    [{char, n + 1} | tail]
  end

  defp push_char([{prev, n} | tail], current) do
    [{current, 1}, {prev, n} | tail]
  end

  defp push_char([], current) do
    [{current, 1}]
  end
end
