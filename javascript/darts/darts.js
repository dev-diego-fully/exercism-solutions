//@ts-check

/**
 * @typedef {{score: number, radius: number}} Target
*/
/**
 * @param {number} score 
 * @param {number} radius
 * @returns {Target} 
 */
function Target(score, radius) {
  return {
    score: score,
    radius: radius
  };
}

const Targets = Object.freeze({
  INNER: Target(10, 1),
  MIDDLE: Target(5, 5),
  OUTER: Target(1, 10),
  OUTSIDE: Target(0, -1)
});

/**
 * @param {number} x 
 * @param {number} y 
 * @returns {number}
 */
function distance(x, y) {
  return Math.sqrt(x ** 2 + y ** 2);
}

/**
 * @param {Target} target 
 * @param {number} x 
 * @param {number} y 
 * @returns {boolean}
 */
function inTarget(target, x, y) {
  return distance(x, y) <= target.radius;
}

/**
 * 
 * @param {number} x 
 * @param {number} y
 * @returns {number}
 */
export const score = (x, y) => {
  if(inTarget(Targets.INNER, x, y)) {
    return Targets.INNER.score;
  }
  if(inTarget(Targets.MIDDLE, x, y)) {
    return Targets.MIDDLE.score;
  }
  if(inTarget(Targets.OUTER, x, y)) {
    return Targets.OUTER.score;
  }
  return Targets.OUTSIDE.score;
};
