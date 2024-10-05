// @ts-check

/**
 * Double every card in the deck.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with every card doubled
 */
export function seeingDouble(deck) {

  return deck.map((card) => 2 * card);

}

/**
 *  Creates triplicates of every 3 found in the deck.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with triplicate 3s
 */
export function threeOfEachThree(deck) {

  /**
   * @param {number[]} acc
   * @param {number} card
   * @returns {number[]}
   */
  return deck.reduce((acc, card) => {

    if (card === 3) {
      acc.push(3, 3, 3);
    } else {
      acc.push(card);
    }

    return acc;

  }, []);


}

/**
 * Extracts the middle two cards from a deck.
 * Assumes a deck is always 10 cards.
 *
 * @param {number[]} deck of 10 cards
 *
 * @returns {number[]} deck with only two middle cards
 */
export function middleTwo(deck) {

  const middle = Math.floor((deck.length - 1) / 2);

  return deck.slice(middle, middle + 2);

}

/**
 * Moves the outside two cards to the middle.
 *
 * @param {number[]} deck with even number of cards
 *
 * @returns {number[]} transformed deck
 */

export function sandwichTrick(deck) {

  const middle = Math.floor((deck.length - 1) / 2);
  const first = deck[0];
  const last = deck[deck.length - 1];
  const firstPart = deck.slice(1, middle + 1);
  const secondPart = deck.slice(middle + 1, -1);

  return [...firstPart, last, first, ...secondPart];

}

/**
 * Removes every card from the deck except 2s.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with only 2s
 */
export function twoIsSpecial(deck) {

  return deck.filter((v) => v === 2);

}

/**
 * Returns a perfectly order deck from lowest to highest.
 *
 * @param {number[]} deck shuffled deck
 *
 * @returns {number[]} ordered deck
 */
export function perfectlyOrdered(deck) {

  return deck.sort((a, b) => a > b ? 1 : -1);

}

/**
 * Reorders the deck so that the top card ends up at the bottom.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} reordered deck
 */
export function reorder(deck) {

  return deck.reverse();

}