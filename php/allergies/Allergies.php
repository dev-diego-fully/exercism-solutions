<?php

declare(strict_types=1);

/**
 * Allergies
 *
 * This class represents a person's allergy profile based on an allergy score.
 * It uses bitwise operations to efficiently determine if a person is allergic to specific items
 * and to retrieve a list of all known allergies.
 */
class Allergies
{
    /**
     * @var int The numeric score representing the person's allergies.
     * Each bit in this integer corresponds to a specific allergen.
     */
    private int $score;

    /**
     * Constructs a new Allergies instance with a given allergy score.
     *
     * @param int $score The integer representing the person's allergy profile.
     */
    public function __construct(int $score)
    {
        $this->score = $score;
    }

    /**
     * Checks if the person is allergic to a specific allergen.
     *
     * This is determined by performing a bitwise AND operation between the allergen's score
     * and the person's total allergy score. If the result is non-zero, it indicates an allergy.
     *
     * @param Allergen $allergen An instance of Allergen representing the allergen to check.
     * @return bool True if the person is allergic to the given allergen, false otherwise.
     *
     * @example
     * $allergies = new Allergies(3); // Score 3 means allergic to Eggs (1) and Peanuts (2)
     * $allergies->isAllergicTo(new Allergen(Allergen::EGGS));    // Returns true
     * $allergies->isAllergicTo(new Allergen(Allergen::PEANUTS)); // Returns true
     * $allergies->isAllergicTo(new Allergen(Allergen::CATS));    // Returns false
     */
    public function isAllergicTo(Allergen $allergen): bool
    {
        return ($allergen->getScore() & $this->score) !== 0;
    }

    /**
     * Retrieves a list of all allergens the person is allergic to.
     *
     * It iterates through a static list of all possible allergens and filters
     * them based on the `isAllergicTo` method.
     *
     * @return array<Allergen> An array of Allergen objects to which the person is allergic.
     *
     * @example
     * $allergies = new Allergies(3); // Allergic to Eggs and Peanuts
     * // $list will contain Allergen objects for Eggs and Peanuts.
     * // Example check: array_map(fn($a) => $a->getScore(), $allergies->getList()) could return [1, 2]
     *
     * $allergies = new Allergies(0); // Allergic to nothing
     * $allergies->getList(); // Returns []
     */
    public function getList(): array
    {
        return array_filter(Allergen::allergenList(), fn($allergen) => $this->isAllergicTo($allergen));
    }

    /**
     * Returns the raw allergy score.
     *
     * @return int The integer score representing the person's allergy profile.
     */
    public function getScore(): int
    {
        return $this->score;
    }
}

/**
 * Allergen
 *
 * This class represents a single allergen with its corresponding score value.
 * Each allergen is assigned a unique power-of-2 score, allowing for bitwise
 * combination in an allergy profile.
 */
class Allergen
{
    /**
     * @var int EGGS Score value for Eggs.
     */
    const EGGS = 1; // 2^0
    /**
     * @var int PEANUTS Score value for Peanuts.
     */
    const PEANUTS = 2; // 2^1
    /**
     * @var int SHELLFISH Score value for Shellfish.
     */
    const SHELLFISH = 4; // 2^2
    /**
     * @var int STRAWBERRIES Score value for Strawberries.
     */
    const STRAWBERRIES = 8; // 2^3
    /**
     * @var int TOMATOES Score value for Tomatoes.
     */
    const TOMATOES = 16; // 2^4
    /**
     * @var int CHOCOLATE Score value for Chocolate.
     */
    const CHOCOLATE = 32; // 2^5
    /**
     * @var int POLLEN Score value for Pollen.
     */
    const POLLEN = 64; // 2^6
    /**
     * @var int CATS Score value for Cats.
     */
    const CATS = 128; // 2^7

    /**
     * Generates a static list of all possible Allergen objects.
     *
     * Each allergen in the list is created with its corresponding power-of-2 score.
     *
     * @return array<Allergen> An array containing an instance for each defined allergen.
     */
    public static function allergenList(): array
    {
        return array_map(fn(int $exp) => new Allergen(2 ** $exp), range(0, 7));
    }

    /**
     * @var int The specific score value of this allergen.
     */
    private int $score;

    /**
     * Constructs a new Allergen instance with a specific score.
     *
     * @param int $score The integer score of the allergen (e.g., 1 for Eggs, 2 for Peanuts).
     */
    public function __construct(int $score)
    {
        $this->score = $score;
    }

    /**
     * Returns the score value of this allergen.
     *
     * @return int The score of the allergen.
     */
    public function getScore(): int
    {
        return $this->score;
    }
}