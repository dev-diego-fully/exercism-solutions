/**
 * 
 * @param {number} start 
 * @param {number} end 
 * @returns {number}
 */
function randomRange(start, end) {
    const randPart = Math.floor(Math.random() * (end - start));

    return start + randPart;
}

/**
 * 
 * @param {any[]} array 
 * @returns {number}
 */
export function randomIndexFor(array) {
    return randomRange(0, array.length);
}