//@ts-check

/**
 * 
 * @param {number} x 
 * @param {number} y 
 * @returns {boolean}
 */
function divisible(x, y) {
  if (y == 0) {
    return false;
  }
  return x % y == 0;
}

const RainDropSound = Object.freeze(
  {
    PLING: "Pling",
    PLANG: "Plang",
    PLONG: "Plong"
  }
);

/**
 * 
 * @param {boolean} drop3 
 * @param {boolean} drop5 
 * @param {boolean} drop7 
 * @returns {string}
 */
function rainSoundFor(drop3, drop5, drop7) {
  let rainSound = "";

  if (drop3) {
    rainSound += RainDropSound.PLING;
  }
  if (drop5) {
    rainSound += RainDropSound.PLANG;
  }
  if (drop7) {
    rainSound += RainDropSound.PLONG;
  }

  return rainSound;
}

/**
 * 
 * @param {number} x 
 * @returns {string}
 */
export const convert = (x) => {

  const rainSound = rainSoundFor(
    divisible(x, 3), divisible(x, 5), divisible(x, 7)
  );
  
  if (rainSound == "") {
    return x.toString();
  }

  return rainSound;
};
