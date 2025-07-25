<?php

declare(strict_types=1);

/**
 * Triangle
 *
 * This class represents a triangle and can classify it based on the lengths of its sides.
 * It ensures that the given side lengths can form a valid triangle.
 */
class Triangle
{
    /**
     * @var int The number of distinct side lengths in the triangle.
     * - 0 for equilateral (all sides equal)
     * - 2 for isosceles (two sides equal)
     * - 3 for scalene (all sides different)
     */
    private int $distinctSides;

    /**
     * Constructs a new Triangle instance with the given side lengths.
     *
     * Validates that all side lengths are positive and that they satisfy the triangle inequality theorem
     * (the sum of the lengths of any two sides of a triangle must be greater than the length of the third side).
     *
     * @param float $a The length of the first side.
     * @param float $b The length of the second side.
     * @param float $c The length of the third side.
     * @throws InvalidArgumentException If the side lengths are not all positive or do not satisfy the triangle inequality.
     */
    public function __construct(float $a, float $b, float $c)
    {
        if (!$this->allPositives($a, $b, $c)) {
            throw new InvalidArgumentException();
        }
        if (!$this->satisfiesInequalities($a, $b, $c)) {
            throw new InvalidArgumentException();
        }
        $this->distinctSides = $this->distinctSidesCount($a, $b, $c);
    }

    /**
     * Classifies the triangle based on its side lengths.
     *
     * @return string The kind of triangle: "scalene", "equilateral", or "isosceles".
     */
    public function kind(): string
    {
        return match (true) {
            $this->distinctSides === 3 => "scalene",
            $this->distinctSides === 0 => "equilateral",
            $this->distinctSides === 2 => "isosceles",
            default => ""
        };
    }

    /**
     * Counts the number of distinct side lengths among the three given sides.
     *
     * This helps in classifying the triangle.
     *
     * @param float $a The length of the first side.
     * @param float $b The length of the second side.
     * @param float $c The length of the third side.
     * @return int The count of distinct side lengths (0, 2, or 3).
     */
    private function distinctSidesCount(float $a, float $b, float $c): int
    {
        return count(array_filter([$a !== $b, $a !== $c, $b !== $c], fn(bool $comp) => $comp));
    }

    /**
     * Checks if the given side lengths satisfy the triangle inequality theorem.
     *
     * The sum of the lengths of any two sides of a triangle must be greater than the length of the third side.
     *
     * @param float $a The length of the first side.
     * @param float $b The length of the second side.
     * @param float $c The length of the third side.
     * @return bool True if the inequalities are satisfied, false otherwise.
     */
    private function satisfiesInequalities(float $a, float $b, float $c): bool
    {
        return match (true) {
            $a + $b < $c => false,
            $a + $c < $b => false,
            $b + $c < $a => false,
            default => true
        };
    }

    /**
     * Checks if all three given side lengths are positive.
     *
     * Side lengths of a triangle must always be greater than zero.
     *
     * @param float $a The length of the first side.
     * @param float $b The length of the second side.
     * @param float $c The length of the third side.
     * @return bool True if all sides are positive, false otherwise.
     *
     */
    private function allPositives(float $a, float $b, float $c): bool
    {
        return array_all([$a, $b, $c], fn(float $val) => $val > 0);
    }
}
