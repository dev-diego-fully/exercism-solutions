defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&rna_complement/1)
  end

  @spec rna_complement(char) :: char
  defp rna_complement(char)

  defp rna_complement(?G), do: ?C
  defp rna_complement(?C), do: ?G
  defp rna_complement(?T), do: ?A
  defp rna_complement(?A), do: ?U
end
