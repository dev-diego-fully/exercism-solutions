export function score(x: number, y: number): number {
  const landedFromCenter = distanceFromCenter(x, y);
  return (
    Object.values(targetCircles).find(({ size }) => landedFromCenter <= size)
      ?.score ?? scoreForOutside
  );
}

function distanceFromCenter(x: number, y: number): number {
  return (x ** 2 + y ** 2) ** (1 / 2);
}

const targetCircles = {
  inner: { size: 1, score: 10 },
  middle: { size: 5, score: 5 },
  outer: { size: 10, score: 1 },
} as const;

const scoreForOutside: number = 0;
