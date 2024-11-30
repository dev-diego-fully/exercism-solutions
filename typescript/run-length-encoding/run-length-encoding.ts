export function encode(str: string) {
  return fromUncoded(str)
    .map(([char, count]) => `${count > 1 ? count : ""}${char}`)
    .join("");
}

export function decode(str: string) {
  return fromEncoded(str)
    .map(([char, count]) => char.repeat(count))
    .join("");
}

function fromUncoded(str: string): [string, number][] {
  return (str.match(patterns.uncoded) ?? []).map((str: string) => [
    str[0],
    str.length,
  ]);
}

function fromEncoded(str: string): [string, number][] {
  return iteratorMap(
    str.matchAll(patterns.encoded) ?? [],
    ([original, count, char]) => {
      if (count != "") {
        return [char, Number(count)];
      }
      return [original, 1];
    }
  );
}

const patterns = {
  uncoded: /([a-zA-Z\s])\1*/g,
  encoded: /(\d*)([a-zA-Z\s])/g,
} as const;

function iteratorMap<T, U>(iterator: Iterable<T>, mapper: (elem: T) => U) {
  const mapped = [];
  for (const elem of iterator) {
    mapped.push(mapper(elem));
  }
  return mapped;
}
