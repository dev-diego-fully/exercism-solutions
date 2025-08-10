// Package queenattack provides a function to determine if two queens on a standard chessboard
// can attack each other.
package queenattack

import (
	"errors"
	"regexp"
)

// CanQueenAttack determines if two queens can attack each other on a chessboard.
// The positions are given in algebraic notation, e.g., "a1", "h8".
// It returns true if an attack is possible, along with a nil error.
// It returns false and an error if the positions are invalid or identical.
func CanQueenAttack(whitePosition, blackPosition string) (bool, error) {
	whiteOk, whiteRow, whiteCol := parse(whitePosition)
	blackOk, blackRow, blackCol := parse(blackPosition)

	if !whiteOk || !blackOk {
		return false, errors.New("invalid position on the board")
	}

	deltaRow := abs(blackRow - whiteRow)
	deltaCol := abs(blackCol - whiteCol)

	if deltaCol == 0 && deltaRow == 0 {
		return false, errors.New("queens cannot occupy the same square")
	}

	return deltaRow == 0 || deltaCol == 0 || deltaRow == deltaCol, nil
}

// parse converts a chessboard position string (e.g., "a1") into a row and column integer.
// It returns a boolean indicating if the parsing was successful.
func parse(position string) (bool, int, int) {
	if regexp.MustCompile("^[a-h][1-8]$").MatchString(position) {
		runes := []rune(position)

		row := int(runes[0] - 'a')
		col := int(runes[1] - '0')

		return true, row, col
	}
	return false, 0, 0
}

// abs returns the absolute value of an integer.
func abs(value int) int {
	if value < 0 {
		return -value
	}
	return value
}
