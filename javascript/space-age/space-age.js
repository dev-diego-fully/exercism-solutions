//
// This is only a SKELETON file for the 'Space Age' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

//@ts-check

const ORBITAL_PERIOD_IN_EARTH_YEARS = Object.freeze(
  {
    "mercury": 0.2408467,
    "venus": 0.61519726,
    "earth": 1,
    "mars": 1.8808158,
    "jupiter": 11.862615,
    "saturn": 29.447498,
    "uranus": 84.016846,
    "neptune": 164.79132
  }
);

const EARTH_YEAR_DURATION_IN_SECONDS = 31557600;

/**
 * 
 * @param {string} planet 
 * @returns {number}
 */
const yearDurationInSeconds = ( planet ) => {

  return (ORBITAL_PERIOD_IN_EARTH_YEARS[ planet ] * 
          EARTH_YEAR_DURATION_IN_SECONDS);

}

/**
 * 
 * @param {number} number 
 * @param {number} precision 
 * @returns {number}
 */
const toPrecision = ( number, precision ) => {

  return Number( number.toFixed( precision ) );

}

/**
 * 
 * @param {string} planet 
 * @param {number} secondsLived 
 * @returns {number}
 */
export const age = ( planet, secondsLived ) => {

  const planetYearDuration = yearDurationInSeconds( planet.toLowerCase() );
  const usedPrecision = 2;

  return toPrecision( secondsLived/planetYearDuration, usedPrecision );

};
