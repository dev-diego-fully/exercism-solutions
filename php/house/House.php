<?php

declare(strict_types=1);

/**
 * House
 *
 * This class generates the lyrics for the traditional English cumulative nursery rhyme,
 * "The House That Jack Built". It provides methods to generate individual verses or a range of verses.
 */
class House
{
    /**
     * @var int The index of the first verse in the rhyme.
     */
    private static int $FIRST_VERSE_INDEX = 1;

    /**
     * @var array<array<string>> A static array containing pairs of rhyme objects and their associated actions.
     * Each inner array represents a line in the rhyme, with the first element being the "object"
     * (e.g., "house that Jack built") and the second being the "action" it suffered
     * (e.g., "lay in").
     */
    private static array $objectAndSuffered = [
        ["house that Jack built", "lay in"],
        ["malt", "ate"],
        ["rat", "killed"],
        ["cat", "worried"],
        ["dog", "tossed"],
        ["cow with the crumpled horn", "milked"],
        ["maiden all forlorn", "kissed"],
        ["man all tattered and torn", "married"],
        ["priest all shaven and shorn", "woke"],
        ["rooster that crowed in the morn", "kept"],
        ["farmer sowing his corn", "belonged to"],
        ["horse and the hound and the horn", ""]
    ];

    /**
     * Generates a specific verse of "The House That Jack Built" rhyme.
     *
     * Each verse is cumulative, meaning it includes all preceding lines up to the specified verse number.
     *
     * @param int $verseNumber The number of the verse to generate (1 to 12).
     * @return array<string> An array of strings, where each string is a line of the specified verse.
     */
    public function verse(int $verseNumber): array
    {
        $versePhrases = $verseNumber;
        $verse = [$this->phraseThisIs($verseNumber)];

        for ($i = $versePhrases - 1; $i >= self::$FIRST_VERSE_INDEX; $i--) {
            array_push($verse, $this->phraseThatSuffered($i));
        }

        return $verse;
    }

    /**
     * Generates a sequence of verses from "The House That Jack Built" rhyme.
     *
     * This method returns all lines for all verses within the specified range,
     * with an empty string separating each complete verse.
     *
     * @param int $start The starting verse number (inclusive, 1 to 12).
     * @param int $end The ending verse number (inclusive, 1 to 12).
     * @return array<string> An array of strings containing all lines for the specified range of verses.
     */
    public function verses(int $start, int $end): array
    {
        $verses = [];

        for ($i = $start; $i <= $end; $i++) {
            foreach ($this->verse($i) as $value) {
                array_push($verses, $value);
            }
            if ($i < $end) {
                array_push($verses, "");
            }
        }

        return $verses;
    }

    /**
     * Generates the opening phrase "This is the [object]." for a given verse number.
     *
     * Adds a period at the end only for the very first verse.
     *
     * @param int $number The verse number (used to determine the object).
     * @return string The formatted opening phrase.
     */
    private function phraseThisIs(int $number): string
    {
        $terminator = $number === self::$FIRST_VERSE_INDEX ? "." : "";
        $object = $this->rhymeObject($number);

        return "This is the $object$terminator";
    }

    /**
     * Generates a cumulative phrase "that [action] the [object]." for a given verse number.
     *
     * Adds a period at the end only for the very first verse's cumulative part.
     *
     * @param int $number The verse number (used to determine the object and action).
     * @return string The formatted cumulative phrase.
     */
    private function phraseThatSuffered(int $number): string
    {
        $terminator = $number === self::$FIRST_VERSE_INDEX ? "." : "";
        $object = $this->rhymeObject($number);
        $action = $this->rhymeAction($number);

        return "that $action the $object$terminator";
    }

    /**
     * Retrieves the rhyme object (e.g., "house that Jack built", "malt") for a given index.
     *
     * @param int $index The 1-based index corresponding to the rhyme line.
     * @return string The rhyme object string.
     */
    private function rhymeObject(int $index): string
    {
        return self::$objectAndSuffered[$index - 1][0];
    }

    /**
     * Retrieves the rhyme action (e.g., "lay in", "ate") for a given index.
     *
     * @param int $index The 1-based index corresponding to the rhyme line.
     * @return string The rhyme action string.
     */
    private function rhymeAction(int $index): string
    {
        return self::$objectAndSuffered[$index - 1][1];
    }
}