/**
 * 
 * @param {number} number 
 * @param {number} base 
 * @returns {number}
 */
function extractDigit(number, base) {
    return number % base;
}

/**
 * 
 * @param {number} number 
 * @param {number|number[]} base 
 */
export function numberToDigits(number, base = 10) {
    if (!Array.isArray(base)) {
        const digits = [];
        let remaining = number;

        while (remaining > 0) {
            digits.push(extractDigit(remaining, base));
            remaining = Math.floor(remaining / base);
        }

        digits.reverse();
        return digits;
    }

    let remaining = number;

    return base
        .map(
            (num) => {
                const digit = extractDigit(remaining, num);
                remaining = Math.floor(remaining / num);
                return digit;
            }
        )
        .reduceRight(
            /**
             * 
             * @param {number[]} acc 
             * @param {number} v 
             * @returns {number[]}
             */
            (acc, v) => acc.concat([v]),
            []
        );
}

/**
 * 
 * @param {number[]} digits 
 * @param {number|number[]} base 
 */
export function digitsToNumber(digits, base) {
    const usingArray = Array.isArray(base);
    
    if(usingArray && digits.length > base.length) {
        throw Error("Invalid base and digits length");
    }

    return digits
        .map(
            (digit, pos) => 
                digit * (usingArray ? base[pos] : base) ** (digits.length - pos - 1)
        )
        .reduce((sum, x) => sum + x);

}