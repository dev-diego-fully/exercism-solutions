export function parse(phrase: string): string {
  return phrase
    .split("")
    .reduce(pushIfInitial, { initials: [], last: " " })
    .initials.join("")
    .toUpperCase();
}

function pushIfInitial(
  queue: { initials: string[]; last: string },
  char: string
): { initials: string[]; last: string } {
  if (
    isSeparator(queue.last) ||
    (isLowerCase(queue.last) && isUpperCase(char))
  ) {
    queue.initials.push(char);
  }
  queue.last = char;
  return queue;
}

function isLowerCase(str: string): boolean {
  return patterns.lowerCase.test(str);
}

function isUpperCase(str: string): boolean {
  return patterns.upperCase.test(str);
}

function isSeparator(str: string): boolean {
  return patterns.separator.test(str);
}

const patterns = {
  lowerCase: /[a-z]/,
  upperCase: /[A-Z]/,
  separator: /[\s\-]/,
} as const;
