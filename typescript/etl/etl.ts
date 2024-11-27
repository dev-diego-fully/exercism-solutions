export function transform(
  old: Record<number, string[]>
): Record<string, number> {
  const transformed: Record<string, number> = {};

  for (const key in old) {
    const numKey = Number(key);
    for (const score of old[numKey]) {
      transformed[score.toLowerCase()] = numKey;
    }
  }

  return transformed;
}
