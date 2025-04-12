defmodule Atbash do
  defmodule CharOps do
    @moduledoc false

    @doc """
    Given the alphabet index of the given character, returns the corresponding letter index in the reversed alphabet.

    ## Examples
    iex> CharOps.translate(?a)
    ?z
    CharOps.translate(?c)
    ?x
    CharOps.translate(?A)
    ?z
    CharOps.translate(?0)
    ?0
    """
    @spec translate(integer) :: integer
    def translate(char)

    # invert lowercase letters
    def translate(char) when char >= ?a and char <= ?z,
      do: ?z - (char - ?a)

    # downcase upper case letters and invert them
    def translate(char) when char >= ?A and char <= ?Z,
      do: ?z - (char - ?A)

    # leave everything else unchanged (digits basically)
    def translate(char),
      do: char

    @doc """
    returns true if the passed characters should not be
    discarded in the translation process.
    """
    @spec keepable?(integer) :: boolean
    def keepable?(char)

    # keep lower case
    def keepable?(char) when char >= ?a and char <= ?z,
      do: true

    # keep upper case
    def keepable?(char) when char >= ?A and char <= ?z,
      do: true

    # keep numbers
    def keepable?(char) when char >= ?0 and char <= ?9,
      do: true

    # discard everything else
    def keepable?(_),
      do: false
  end

  @separator ?\s
  @separator_interval 5

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.to_charlist()
    |> Stream.filter(&CharOps.keepable?/1)
    |> Stream.map(&CharOps.translate/1)
    |> CustomListOps.insert_every(@separator_interval, @separator)
    |> List.to_string()
  end

  @doc """
  Decodes a given ciphertext to the corresponding plaintext

  ## Examples
  iex> Atbash.decode("gvhgr mt123 gvhgr mt")
  "testing123testing"
  """
  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.to_charlist()
    |> Stream.filter(&CharOps.keepable?/1)
    |> Enum.map(&CharOps.translate/1)
    |> List.to_string()
  end
end
