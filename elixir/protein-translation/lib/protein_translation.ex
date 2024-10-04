defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    translation =
      ~r/.{1,3}/
      |> Regex.scan(rna)
      |> List.flatten()
      |> Enum.map(&protein_for/1)
      |> Enum.reduce(
        %{list: [], stopped: false},
        fn p, %{list: list, stopped: stopped?} = translation ->
          cond do
            stopped? -> translation
            p == "STOP" -> %{list: list, stopped: true}
            true -> %{list: list ++ [p], stopped: false}
          end
        end
      )
      |> Map.get(:list)

    if translation |> Enum.any?(&is_nil/1) do
      {:error, "invalid RNA"}
    else
      {:ok, translation}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case protein_for(codon) do
      nil -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end

  @spec protein_for(String.t()) :: String.t() | nil
  defp protein_for(codon) do
    case codon do
      "UGU" -> "Cysteine"
      "UGC" -> "Cysteine"
      "UUA" -> "Leucine"
      "UUG" -> "Leucine"
      "AUG" -> "Methionine"
      "UUU" -> "Phenylalanine"
      "UUC" -> "Phenylalanine"
      "UCU" -> "Serine"
      "UCC" -> "Serine"
      "UCA" -> "Serine"
      "UCG" -> "Serine"
      "UGG" -> "Tryptophan"
      "UAU" -> "Tyrosine"
      "UAC" -> "Tyrosine"
      "UAA" -> "STOP"
      "UAG" -> "STOP"
      "UGA" -> "STOP"
      _ -> nil
    end
  end
end
