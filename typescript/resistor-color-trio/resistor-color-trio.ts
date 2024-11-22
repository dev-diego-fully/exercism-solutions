const invalidResistorColor = -1;

export function decodedResistorValue(
  colors: Array<(typeof COLORS)[number]>
): string | undefined {
  const [ten, unity, zeros]: number[] = colors.map(decodedResistorColor);

  if (![ten, unity, zeros].includes(invalidResistorColor)) {
    return toMetrics((ten * 10 + unity) * Math.pow(10, zeros));
  }
}

function decodedResistorColor(color: (typeof COLORS)[number]): number {
  return COLORS.indexOf(color);
}

function toMetrics(value: number): string | undefined {
  const metric = metrics.find(({ limit }) => value < limit);

  if (metric) {
    return `${value / metric.base} ${metric.prefix}`;
  }
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

const metrics = [
  { prefix: "ohms", base: 10e-1, limit: 10e2 },
  { prefix: "kiloohms", base: 10e2, limit: 10e5 },
  { prefix: "megaohms", base: 10e5, limit: 10e8 },
  { prefix: "gigaohms", base: 10e8, limit: 10e11 },
] as const;
