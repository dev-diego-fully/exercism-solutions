defmodule SimpleCipher do
  @alphabet_size 26

  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    plain_pos =
      plaintext
      |> String.to_charlist()
      |> Enum.map(&alphabet_position/1)

    key_pos =
      key
      |> String.to_charlist()
      |> Enum.map(&alphabet_position/1)

    do_encode(plain_pos, key_pos)
    |> Enum.map(&from_alphabet_position/1)
    |> to_string()
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    cipher_pos =
      ciphertext
      |> String.to_charlist()
      |> Enum.map(&alphabet_position/1)

    key_pos =
      key
      |> String.to_charlist()
      |> Enum.map(&alphabet_position/1)

    do_decode(cipher_pos, key_pos)
    |> Enum.map(&from_alphabet_position/1)
    |> to_string()
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    1..length
    |> Enum.map(fn _ -> ?a + Enum.random(0..(@alphabet_size - 1)) end)
    |> to_string()
  end

  defp do_encode(plain_pos, key_pos, cache \\ [])

  defp do_encode([], _, cache), do: cache

  defp do_encode(plain_pos, key_pos, cache) when length(plain_pos) > length(key_pos) do
    {part1, part2} = Enum.split(plain_pos, length(key_pos))
    do_encode(part2, key_pos, Enum.concat(cache, do_encode(part1, key_pos)))
  end

  defp do_encode(plain_pos, key, cache) do
    Enum.concat(
      cache,
      Enum.zip(plain_pos, key)
      |> Enum.map(fn {p, k} -> rotate(p, k) end)
    )
  end

  defp do_decode(plain_pos, key_pos, cache \\ [])

  defp do_decode([], _, cache), do: cache

  defp do_decode(plain_pos, key_pos, cache) when length(plain_pos) > length(key_pos) do
    {part1, part2} = Enum.split(plain_pos, length(key_pos))
    do_decode(part2, key_pos, Enum.concat(cache, do_decode(part1, key_pos)))
  end

  defp do_decode(plain_pos, key, cache) do
    Enum.concat(
      cache,
      Enum.zip(plain_pos, key)
      |> Enum.map(fn {p, k} -> de_rotate(p, k) end)
    )
  end

  defp alphabet_position(letter),
    do: letter - ?a

  defp from_alphabet_position(alpha_pos),
    do: alpha_pos + ?a

  defp rotate(alpha_pos, rotations),
    do: (alpha_pos + rotations) |> rem(@alphabet_size)

  defp de_rotate(alpha_pos, rotations) do
    after_rotations = alpha_pos - rotations

    if after_rotations < 0 do
      @alphabet_size + after_rotations
    else
      after_rotations
    end
  end
end
