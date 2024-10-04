defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000
  def encode_nucleotide(_), do: nil

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T
  def decode_nucleotide(_), do: nil

  def encode(dna), do: do_encode(dna, <<>>)
  def decode(dna), do: do_decode(dna, [])

  defp do_encode([current | next], acc) do
    do_encode(next, <<acc::bitstring, encode_nucleotide(current)::4>>)
  end

  defp do_encode([], acc) do
    acc
  end

  defp do_decode(<<>>, acc) do
    acc
  end

  defp do_decode(<<current::4, rest::bitstring>>, acc) do
    do_decode( rest, acc ++ [decode_nucleotide(current)] )
  end

end
