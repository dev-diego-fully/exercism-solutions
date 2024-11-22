export function decodedValue([a, b]: Array<(typeof COLORS)[number]>): number {
  const invalidResistorColor = -1;
  let [valueA, valueB] = [COLORS.indexOf(a), COLORS.indexOf(b)];

  if (valueA != invalidResistorColor && valueB != invalidResistorColor) {
    return valueA * 10 + valueB;
  }

  return invalidResistorColor;
}

const COLORS = [
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
] as const;
