export function hey(message: string): string {
  return (
    Object.values(bobResponses.specials).find(({ isTriggeredBy }) => isTriggeredBy(message))
      ?.response ?? bobResponses.regular
  );
}

const bobResponses = {
  specials: {
    yellingQuestions: {
      response: "Calm down, I know what I'm doing!",
      isTriggeredBy: (msg: string): boolean =>
        patterns.yellings.test(msg) && patterns.questions.test(msg),
    },
    questions: {
      response: "Sure.",
      isTriggeredBy: (msg: string): boolean => patterns.questions.test(msg),
    },
    yellings: {
      response: "Whoa, chill out!",
      isTriggeredBy: (msg: string): boolean => patterns.yellings.test(msg),
    },
    silences: {
      response: "Fine. Be that way!",
      isTriggeredBy: (msg: string): boolean => patterns.silences.test(msg),
    },
  },
  regular: "Whatever.",
} as const;

const patterns = {
  questions: /^.*\?\s*$/,
  yellings: /^(?=.*[A-Z])[^a-z]*$/,
  silences: /^\s*$/,
} as const;
