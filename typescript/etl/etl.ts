export function transform(
  old: Record<number, string[]>
): Record<string, number> {
  return Object.fromEntries(
    Object.entries(old).flatMap(([key, value]) => {
      const numKey = Number(key);
      return value.map((val) => [val.toLowerCase(), numKey]);
    })
  );
}
