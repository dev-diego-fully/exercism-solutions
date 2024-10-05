/// <reference path="./global.d.ts" />
// @ts-check

/**
 * Implement the functions needed to solve the exercise here.
 * Do not forget to export them so they are available for the
 * tests. Here an example of the syntax as reminder:
 *
 * export function yourFunction(...) {
 *   ...
 * }
 */

/**
 * 
 * @param {number} remainingTime 
 * @returns {string}
 */
export function cookingStatus( remainingTime ) {

    switch( remainingTime ) {

        case 0:
            return 'Lasagna is done.';

        case undefined:
            return 'You forgot to set the timer.';

        default:
            return 'Not done, please wait.';

    }

}

/**
 * 
 * @param {string[]} layers 
 * @param {number}[timeNeededPerLayer=2]
 * @returns {number}
 */
export function preparationTime( layers, timeNeededPerLayer = 2 ) {

    return layers.length * timeNeededPerLayer;

}

/**
 * 
 * @param {string[]} layers
 * @returns {object}
 */
export function quantities(layers) {

    const perLayer = {
        noodles: 50,
        sauce: 0.2
    }

    /**
     * 
     * @param {string} ingredient 
     * @param {string[]} lasagna 
     * @returns {number}
     */
    const layersOf = ( ingredient, lasagna ) => {
        return lasagna.filter( ( i ) => i == ingredient ).length;
    }

    /**
     * 
     * @param {number} numOfLayers 
     * @param {number} ingredientCountPerLayer 
     * @returns {number}
     */
    const requiredFor = ( numOfLayers, ingredientCountPerLayer ) => {
        return numOfLayers * ingredientCountPerLayer;
    }

    return {
        noodles: requiredFor(
            layersOf( "noodles", layers ), perLayer.noodles
        ),
        sauce: requiredFor(
            layersOf( "sauce", layers ), perLayer.sauce
        )
    }

}

/**
 * 
 * @param {string[]} friendsList 
 * @param {string[]} myList 
 */
export function addSecretIngredient(friendsList, myList) {

    myList.push( friendsList.at( -1 ) ?? "" );

}

/**
 * 
 * @param {object} recipe 
 * @param {number} portions 
 * @returns {object}
 */
export function scaleRecipe(recipe, portions) {

    const scaled = {};
    const actualPortion = 2;
    /**
     * 
     * @param {number} value
     * @param {number} actualBase 
     * @param {number} desiredBase
     * @returns 
     */
    const scale = ( value, actualBase, desiredBase ) => {
        return value/actualBase * desiredBase;
    };

    for( const [ ingredient, amount ] of Object.entries( recipe ) ) {

        scaled[ ingredient ] = scale( amount, actualPortion, portions );

    }

    return scaled;

}