export function toRna(strand: string): string {
  return strand
    .split("")
    .map(fromDnaToRna)
    .join("");
}

function fromDnaToRna(nucleotide: string): string {
  switch(nucleotide) {
    case "C":
      return "G";
    case "G":
      return "C";
    case "A":
      return "U";
    case "T":
      return "A";
    default:
      throw "Invalid input DNA.";
  }
}