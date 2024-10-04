defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> prepare_to_atbash()
    |> execute_atbash()
    |> separate_string(5)
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> prepare_to_atbash()
    |> execute_atbash()
  end

  defp translate(char) when char < ?a or char > ?z, do: char
  defp translate(char), do: ?z - (char - ?a)

  defp separate_string(string, char_count) do
    Regex.compile!(".{1,#{char_count}}")
    |> Regex.scan(string)
    |> Enum.join(" ")
  end

  defp prepare_to_atbash(str) do
    str
    |> String.downcase()
    |> String.replace(~r/\W/, "")
    |> String.to_charlist()
  end

  defp execute_atbash(char_list) do
    char_list
    |> Enum.map(&translate/1)
    |> to_string()
  end
end
