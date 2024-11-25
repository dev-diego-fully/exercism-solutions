export function translate(strand: string) {
  return mapUntil(
    breakInCodons(strand),
    translateCodon,
    (codon: string) => translateCodon(codon) === "STOP"
  );
}

function breakInCodons(strand: string): Array<string> {
  const codonsPattern = /.{1,3}/g;
  return strand.match(codonsPattern) ?? [];
}

function translateCodon(codon: string): string {
  if (!codonsTranslationMap[codon]) {
    throw new Error("Invalid codon");
  }
  return codonsTranslationMap[codon];
}

const codonsTranslationMap: Record<string, string> = {
  AUG: "Methionine",
  UUU: "Phenylalanine",
  UUC: "Phenylalanine",
  UUA: "Leucine",
  UUG: "Leucine",
  UCU: "Serine",
  UCC: "Serine",
  UCA: "Serine",
  UCG: "Serine",
  UAU: "Tyrosine",
  UAC: "Tyrosine",
  UGU: "Cysteine",
  UGC: "Cysteine",
  UGG: "Tryptophan",
  UAA: "STOP",
  UAG: "STOP",
  UGA: "STOP",
} as const;

function mapUntil(
  collection: Array<string>,
  mapper: (value: string) => any,
  condition: (value: string) => boolean
) {
  const mapped = [];

  for (const element of collection) {
    if (condition(element)) {
      return mapped;
    }
    mapped.push(mapper(element));
  }

  return mapped;
}
