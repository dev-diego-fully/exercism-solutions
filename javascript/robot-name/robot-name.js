//@ts-check
import { numberToDigits, digitsToNumber } from "./number.js";
import { randomIndexFor } from "./random";

const nameFormat = Object.freeze([26, 26, 10, 10, 10]);

/**
 * 
 * @param {number} number
 * @returns {string} 
 */
function letter(number) {
    return String.fromCharCode(65 + number);
}


/**
 * 
 * @param {number} number
 * @returns {string}
 */
function toName(number) {
    return numberToDigits(number, [...nameFormat])
        .map((x, i) => i > 2 ? letter(x) : String(x))
        .reduceRight((acc, v) => acc.concat(v))
}


export class Robot {

    static #notUsedNames = [];

    static releaseNames() {
        this.#notUsedNames = Array
            .from(Array((26 ** 2) * (10 ** 3)).keys());
    }

    static #randomName() {
        if (this.#notUsedNames.length < 1) {
            throw new Error("No name avaliable");
        }
        const nameIndex = randomIndexFor(this.#notUsedNames);
        const nameNumber = this.#notUsedNames[nameIndex];

        this.#notUsedNames.splice(nameIndex, 1);

        return toName(nameNumber);
    }

    #name;

    constructor() {
        this.#name = Robot.#randomName();
    }

    get name() {
        return this.#name;
    }

    reset() {
        this.#name = Robot.#randomName();
    }

}

Robot.releaseNames();