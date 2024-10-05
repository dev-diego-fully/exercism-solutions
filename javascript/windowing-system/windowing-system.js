// @ts-check

/**
 * Implement the classes etc. that are needed to solve the
 * exercise in this file. Do not forget to export the entities
 * you defined so they are available for the tests.
 */

/**
 * @param {number} value
 * @param {number} min 
 * @param {number} max
 * @returns {number}
 */
function clamp( value, min, max) {

    return Math.min( Math.max( min, value ), max );

}

export class Size {

    /**
     * 
     * @param {number} width 
     * @param {number} height 
     */
    constructor( width = 80, height = 60 ) {

        this.width = width;
        this.height = height;

    }

    /**
     * 
     * @param {number} newWidth 
     * @param {number} newHeight 
     */
    resize( newWidth, newHeight ) {

        [ this.width, this.height ] = [ newWidth, newHeight ];

    }


}

export class Position {

    /**
     * 
     * @param {number} x 
     * @param {number} y 
     */
    constructor( x = 0, y = 0 ) {
        this.x = x;
        this.y = y;
    }

    /**
     * 
     * @param {number} newX 
     * @param {number} newY 
     */
    move( newX, newY ) {
        [ this.x, this.y ] = [ newX, newY ];
    }


}

export class ProgramWindow {

    constructor() {

        this.screenSize = new Size( 800, 600 );
        this.size = new Size();
        this.position = new Position();

    }

    /**
     * 
     * @param {Size} newSize 
     */
    resize( newSize ) {

        const [ minWidth, minHeight ] = [ 1, 1 ];
        const [ maxWidth, maxHeight ] = [
            this.screenSize.width - this.position.x,
            this.screenSize.height - this.position.y
        ];

        this.size = new Size( 
            clamp( newSize.width, minWidth, maxWidth ),
            clamp( newSize.height, minHeight, maxHeight )
        );

    }

    /**
     * 
     * @param {Position} newPosition 
     */
    move( newPosition ) {

        const [ minX, minY ] = [ 0, 0 ]; 
        const [ maxX, maxY ] = [ 
            this.screenSize.width - this.size.width,
            this.screenSize.height - this.size.height
        ];

        this.position = new Position(
            clamp( newPosition.x, minX, maxX ),
            clamp( newPosition.y, minY, maxY )
        );

    }

}

/**
 * 
 * @param {ProgramWindow} changed 
 * @returns {ProgramWindow} 
 */
export function changeWindow( changed ) {

    const predefined = {
        width: 400,
        height: 300,
        x: 100,
        y: 150
    };

    changed.resize( new Size( predefined.width, predefined.height ) );
    changed.move( new Position( predefined.x, predefined.y ) );

    return changed;

}