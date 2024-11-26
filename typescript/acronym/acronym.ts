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
) {
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
  return /[a-z]/.test(str);
}

function isUpperCase(str: string): boolean {
  return /[A-Z]/.test(str);
}

function isSeparator(str: string): boolean {
  return /[\s\-]/.test(str);
}
