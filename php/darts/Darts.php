<?php

declare(strict_types=1);

/**
 * Darts
 *
 * This class calculates the score obtained in a game of darts based on where the dart lands on the board.
 * The score is determined by the distance of the dart from the center of the board.
 */
class Darts
{
    /**
     * @var int The final score obtained for the dart throw.
     */
    public int $score = 0;

    /**
     * Constructs a new Darts instance and calculates the score for the given dart coordinates.
     *
     * The constructor takes the X and Y coordinates of where the dart landed.
     * It then calculates the distance from the center and determines the score.
     *
     * @param float $xAxis The X-coordinate of where the dart landed.
     * @param float $yAxis The Y-coordinate of where the dart landed.
     */
    public function __construct(float $xAxis, float $yAxis)
    {
        $this->score = self::scoreFor(self::distanceFromCenter($xAxis, $yAxis));
    }

    /**
     * Calculates the Euclidean distance of a point from the origin (0,0).
     *
     * This method is used to find how far the dart landed from the exact center of the dartboard.
     *
     * @param float $xAxis The X-coordinate.
     * @param float $yAxis The Y-coordinate.
     * @return float The distance from the center.
     */
    private static function distanceFromCenter(float $xAxis, float $yAxis): float
    {
        return sqrt($xAxis ** 2 + $yAxis ** 2);
    }

    /**
     * Determines the score based on the distance of the dart from the center.
     *
     * The score is determined by predefined concentric rings on the dartboard.
     *
     * @param float $distance The calculated distance from the center of the board.
     * @return int The score obtained for that distance.
     */
    private static function scoreFor(float $distance): int
    {
        foreach (self::TARGET_SCORES_PER_RADIUS as $target_distance => $score) {
            if ($distance <= $target_distance) {
                return $score;
            }
        }

        return self::DEFAULT_SCORE;
    }

    /**
     * @var array<int, int> TARGET_SCORES_PER_RADIUS A constant array mapping maximum radius to score.
     * - Radius 1: 10 points (inner circle)
     * - Radius 5: 5 points (middle circle)
     * - Radius 10: 1 point (outer circle)
     */
    const TARGET_SCORES_PER_RADIUS = [
        1 => 10,
        5 => 5,
        10 => 1,
    ];

    /**
     * @var int DEFAULT_SCORE The default score awarded if the dart lands outside all scoring rings.
     */
    const DEFAULT_SCORE = 0;
}