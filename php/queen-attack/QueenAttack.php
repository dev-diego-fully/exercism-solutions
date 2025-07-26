<?php

declare(strict_types=1);

/**
 * Validates if a given coordinate pair represents a valid position on a standard 8x8 chessboard.
 *
 * A valid position must have both X (rank) and Y (file) coordinates between 0 and 7, inclusive.
 *
 * @param int $xCoordinate The X-coordinate (rank) of the queen's position.
 * @param int $yCoordinate The Y-coordinate (file) of the queen's position.
 * @return bool True if the position is valid.
 * @throws InvalidArgumentException If the coordinates are out of bounds (less than 0 or greater than 7).
 */
function placeQueen(int $xCoordinate, int $yCoordinate): bool
{
    if ($xCoordinate > 7 || $yCoordinate > 7) {
        throw new InvalidArgumentException('The position must be on a standard size chess board.');
    }

    if ($xCoordinate < 0 || $yCoordinate < 0) {
        throw new InvalidArgumentException('The rank and file numbers must be positive.');
    }

    return true;
}

/**
 * Determines if two queens placed on a chessboard can attack each other.
 *
 * Queens can attack if they are on the same rank (row), same file (column), or same diagonal.
 * This function utilizes helper functions to check each of these conditions.
 *
 * @param array<int> $whiteQueen An array representing the coordinates [x, y] of the white queen.
 * @param array<int> $blackQueen An array representing the coordinates [x, y] of the black queen.
 * @return bool True if either queen can attack the other, false otherwise.
 *
 * @example
 * canAttack([0, 0], [0, 7]); // Returns true (same rank)
 * canAttack([0, 0], [7, 0]); // Returns true (same file)
 * canAttack([0, 0], [6, 6]); // Returns true (same diagonal)
 * canAttack([0, 0], [1, 2]); // Returns false
 */
function canAttack(array $whiteQueen, array $blackQueen): bool
{
    return array_any(
        ["isInSameRank", "isInSameFile", "isInSameDiagonal"],
        fn($cond) => $cond($whiteQueen, $blackQueen)
    );
}

/**
 * Checks if two queens are in the same rank (row).
 *
 * @param array<int> $whiteQueen The coordinates [x, y] of the white queen.
 * @param array<int> $blackQueen The coordinates [x, y] of the black queen.
 * @return bool True if their X-coordinates are identical, false otherwise.
 */
function isInSameRank(array $whiteQueen, array $blackQueen): bool
{
    return $whiteQueen[0] === $blackQueen[0];
}

/**
 * Checks if two queens are in the same file (column).
 *
 * @param array<int> $whiteQueen The coordinates [x, y] of the white queen.
 * @param array<int> $blackQueen The coordinates [x, y] of the black queen.
 * @return bool True if their Y-coordinates are identical, false otherwise.
 */
function isInSameFile(array $whiteQueen, array $blackQueen): bool
{
    return $whiteQueen[1] === $blackQueen[1];
}

/**
 * Checks if two queens are in the same diagonal.
 *
 * Queens are on the same diagonal if the absolute difference between their X-coordinates
 * is equal to the absolute difference between their Y-coordinates.
 *
 * @param array<int> $whiteQueen The coordinates [x, y] of the white queen.
 * @param array<int> $blackQueen The coordinates [x, y] of the black queen.
 * @return bool True if they are on the same diagonal, false otherwise.
 */
function isInSameDiagonal(array $whiteQueen, array $blackQueen): bool
{
    $rankDiff = abs($whiteQueen[0] - $blackQueen[0]);
    $fileDiff = abs($whiteQueen[1] - $blackQueen[1]);

    return $rankDiff === $fileDiff;
}