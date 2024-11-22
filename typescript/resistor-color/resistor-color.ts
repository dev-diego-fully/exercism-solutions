export const colorCode = (code: (typeof COLORS)[number]): number =>
  COLORS.indexOf(code);

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
