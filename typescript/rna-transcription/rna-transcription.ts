export function toRna(strand: string): string {
  return strand
    .split("")
    .map(fromDnaToRna)
    .join("");
}

const DNA_TO_RNA: Record<string, string> = {
  C: "G",
  G: "C",
  A: "U",
  T: "A"
} as const

function fromDnaToRna(nucleotide: string): string {
  const translated = DNA_TO_RNA[nucleotide];
  
  if(translated) {
    return translated;
  }
  
  throw new Error("Invalid input DNA.");
}