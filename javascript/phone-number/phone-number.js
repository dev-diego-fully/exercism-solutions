//@ts-check
/**
 * @typedef {{number: string, country: string, areaCode: string, exchange: string, subscriberNumber: string}} PhoneNumber
 * @typedef {[true, any]|[false, string]} Result
 */

/**
 * 
 * @param {boolean} success 
 * @param {string|any} dataOrReason
 * @returns {Result}
 */
function Result(success, dataOrReason = undefined) {
  if (!success && typeof dataOrReason != "string") {
    throw new Error();
  }
  return [success, dataOrReason];
}

/**
 * 
 * @param {string} number 
 * @returns {boolean}
 */
function hasLetters(number) {
  const lettersPattern = /[a-z]/i;

  return number.match(lettersPattern) !== null;
}

/**
 * 
 * @param {string} number 
 * @returns {boolean}
 */
function hasInvalidCaracters(number) {
  const notAcceptablePattern = /[^\d\s\(\)-\.]/g;

  return number.match(notAcceptablePattern) !== null;
}

/**
 * 
 * @param {string} area 
 * @returns {Result}
 */
function validAreaCode(area) {
  const startDigit = area.charAt(0);

  if (startDigit == "0") {
    return Result(false, "Area code cannot start with zero");
  }

  if (startDigit == "1") {
    return Result(false, "Area code cannot start with one");
  }

  return Result(true, "");
}

/**
 * 
 * @param {string} exchange
 * @returns {Result}
 */
function validExchange(exchange) {
  const startDigit = exchange.charAt(0);

  if (startDigit == "0") {
    return Result(false, "Exchange code cannot start with zero");
  }

  if (startDigit == "1") {
    return Result(false, "Exchange code cannot start with one");
  }

  return Result(true, "");
}

/**
 * 
 * @param {string} code 
 * @returns {Result}
 */
function validCountry(code) {
  if (code === undefined || code === "1") {
    return [true, ""];
  }
  return [false, "11 digits must start with 1"];
}

/**
 * 
 * @param {string} number 
 * @returns {[true, PhoneNumber]|[false, string]}
 */
function getSplittedNumber(number) {
  const trashPattern = /[^\d]/g;
  const numberPattern = /^(\d)?(\d{3})(\d{3})(\d{4})$/;
  const phoneNumber = number.replace(trashPattern, "");

  const match = numberPattern.exec(phoneNumber);

  if (!match) {
    if (phoneNumber.length > 11) {
      return Result(false, "More than 11 digits");
    }
    if (phoneNumber.length < 10) {
      return Result(false, "Incorrect number of digits");
    }

  }

  const [_, country, areaCode, exchange, subscriberNumber] = match;

  return [
    true,
    {
      number: phoneNumber,
      country: country,
      areaCode: areaCode,
      exchange: exchange,
      subscriberNumber: subscriberNumber
    }
  ];

}


/**
 * 
 * @param {string} number
 * @returns {string}
 */
export const clean = (number) => {
  if (hasInvalidCaracters(number)) {
    console.log(number)
    if (hasLetters(number)) {
      throw new Error("Letters not permitted");
    }
    throw new Error("Punctuations not permitted");
  }


  let [ok, reasonOrData] = getSplittedNumber(number);

  if (!ok) {
    throw new Error(reasonOrData);
  }
  const phoneNumber = reasonOrData;

  let reason;

  [ok, reason] = validCountry(phoneNumber.country);
  if (!ok) {
    throw new Error(reason);
  }

  [ok, reason] = validAreaCode(phoneNumber.areaCode);
  if (!ok) {
    throw new Error(reason);
  }

  [ok, reason] = validExchange(phoneNumber.exchange);
  if (!ok) {
    throw new Error(reason);
  }

  return `${phoneNumber?.areaCode}${phoneNumber.exchange}${phoneNumber.subscriberNumber}`;

};
