// @ts-check

/**
 * 
 * @param {any} value 
 * @returns {boolean}
 */
function isPresent( value ) {

  return value !== null && value !== undefined;

}

/**
 * Given a certain command, help the chatbot recognize whether the command is valid or not.
 *
 * @param {string} command
 * @returns {boolean} whether or not is the command valid
 */
export function isValidCommand(command) {

  const commandRegex = /^chatbot/i;

  return isPresent( command.match( commandRegex ) );

}

/**
 * Given a certain message, help the chatbot get rid of all the emoji's encryption through the message.
 *
 * @param {string} message
 * @returns {string} The message without the emojis encryption
 */
export function removeEmoji(message) {

  const emojiRegex = /emoji\d*/gi;
  const substitute = "";

  return message.replace( emojiRegex, substitute );

}

/**
 * Given a certain phone number, help the chatbot recognize whether it is in the correct format.
 *
 * @param {string} number
 * @returns {string} the Chatbot response to the phone Validation
 */
export function checkPhoneNumber(number) {

  const phoneFormat = /^(\(\+\d{2}\)) (\d{3}\-){2}(\d{3})/;

  if( isPresent( number.match( phoneFormat ) ) ) {

    return "Thanks! You can now download me to your phone.";

  }

  return `Oops, it seems like I can't reach out to ${number}`;

}

/**
 * Given a certain response from the user, help the chatbot get only the URL.
 *
 * @param {string} userInput
 * @returns {string[] | null} all the possible URL's that the user may have answered
 */
export function getURL(userInput) {

  const urlRegex = /\b\w+\.\w+\b/gi;
  const urls = [];

  const matches = userInput.matchAll( urlRegex );

  for( const match of matches ) {

    urls.push( ...match );

  }

  return urls.length > 0 ? urls : null;

}

/**
 * Greet the user using the full name data from the profile.
 *
 * @param {string} fullName
 * @returns {string} Greeting from the chatbot
 */
export function niceToMeetYou(fullName) {
  
  const [ firstNameIndex, lastNameIndex ] = [ 2, 1 ];
  const fullNameRagex = /([A-Z][a-z]+)\, ([A-Z][a-z]+)/;

  const matchedName = fullName.match( fullNameRagex );
  const defaultMessage = "Nice to meet you, ";

  if( isPresent(matchedName) ) {
    
    const [ firstName, lastName ] = [ 
      matchedName[ firstNameIndex ], matchedName[ lastNameIndex ]
    ];

    return `${defaultMessage}${firstName} ${lastName}`;

  }

  
}
