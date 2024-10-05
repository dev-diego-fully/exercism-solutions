//
// This is only a SKELETON file for the 'Bob' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const responses = Object.freeze({
  questions: "Sure.",
  screams: "Whoa, chill out!",
  screamQuestions: "Calm down, I know what I'm doing!",
  silences: "Fine. Be that way!",
  default: "Whatever."
});

/**
 * 
 * @param {string} message
 * @returns {string}
 */
export const hey = (message) => {
  if (isSilence(message)) {
    return responses.silences;
  }
  const isScreaming = isScream(message);
  const isQuestioning = isQuestion(message);

  if (isScreaming && isQuestioning) {
    return responses.screamQuestions;
  }

  if (isQuestioning) {
    return responses.questions;
  }

  if (isScreaming) {
    return responses.screams;
  }

  return responses.default;
};

/**
 * 
 * @param {string} message
 * @returns {boolean}
 */
function isQuestion(message) {
  const question_pattern = /\?\s*$/;

  return message.match(question_pattern);
}

/**
 * 
 * @param {string} message
 * @returns {boolean}
 */
function isScream(message) {
  return message.match(/[A-Z]/) && !message.match(/[a-z]/);
}

/**
 * 
 * @param {string} message
 * @returns {boolean}
 */
function isSilence(message) {
  return !message.match(/\S/);
}