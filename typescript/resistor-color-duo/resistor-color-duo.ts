export function decodedValue([a, b]: Array<(typeof COLORS)[number]>): number {
  const invalid_color_code = -1;
  let [valueA, valueB] = [COLORS.indexOf(a), COLORS.indexOf(b)];

  if (valueA != invalid_color_code && valueB != invalid_color_code) {
    return valueA * 10 + valueB;
  }

  return invalid_color_code;
}

export const COLORS = [
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
