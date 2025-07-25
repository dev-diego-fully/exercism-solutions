<?php

declare(strict_types=1);

/**
 * Sublist
 *
 * This class provides functionality to compare two lists (arrays) and determine
 * their relationship: whether one is a sublist of the other, a superlist,
 * if they are equal, or if they are entirely unequal.
 */
class Sublist
{
    /**
     * Compares two lists to determine their relationship.
     *
     * The possible relationships are:
     * - "EQUAL": Both lists contain the same elements in the same order.
     * - "SUBLIST": `listOne` is a contiguous sub-sequence of `listTwo`.
     * - "SUPERLIST": `listTwo` is a contiguous sub-sequence of `listOne`.
     * - "UNEQUAL": Neither list is a sublist or superlist of the other, and they are not equal.
     *
     * @param array $listOne The first list to compare.
     * @param array $listTwo The second list to compare.
     * @return string The relationship between the two lists ("EQUAL", "SUBLIST", "SUPERLIST", "UNEQUAL").
     *
     * @example
     * // Empty lists
     * $sublist->compare([], []); // Returns "EQUAL"
     *
     * // Empty list within non-empty list
     * $sublist->compare([], [1, 2, 3]); // Returns "SUBLIST"
     *
     * // Non-empty list contains empty list
     * $sublist->compare([1, 2, 3], []); // Returns "SUPERLIST"
     *
     * // List equals itself
     * $sublist->compare([1, 2, 3], [1, 2, 3]); // Returns "EQUAL"
     *
     * // Sublist at start
     * $sublist->compare([0, 1, 2], [0, 1, 2, 3, 4, 5]); // Returns "SUBLIST"
     *
     * // Sublist in middle
     * $sublist->compare([2, 3, 4], [0, 1, 2, 3, 4, 5]); // Returns "SUBLIST"
     *
     * // Superlist in middle
     * $sublist->compare([0, 1, 2, 3, 4, 5], [2, 3]); // Returns "SUPERLIST"
     *
     * // Different lists
     * $sublist->compare([1, 2, 3], [2, 3, 4]); // Returns "UNEQUAL"
     */
    public function compare(array $listOne, array $listTwo): string
    {
        $oneIsSubOfTwo = $this->isSubListOf($listOne, $listTwo);
        $twoIsSubOfOne = $this->isSubListOf($listTwo, $listOne);

        if ($oneIsSubOfTwo && $twoIsSubOfOne) {
            return "EQUAL";
        } else if ($oneIsSubOfTwo) {
            return "SUBLIST";
        } else if ($twoIsSubOfOne) {
            return "SUPERLIST";
        } else {
            return "UNEQUAL";
        }
    }

    /**
     * Checks if one list (`$sub`) is a contiguous sub-sequence of another list (`$super`).
     *
     * An empty list is considered a sublist of any list (including another empty list).
     *
     * @param array $sub The potential sublist.
     * @param array $super The potential superlist.
     * @return bool True if `$sub` is a sublist of `$super`, false otherwise.
     */
    private function isSublistOf(array $sub, array $super): bool
    {
        $subLen = count($sub);

        if ($subLen === 0) {
            return true;
        }

        $superLen = count($super);

        if ($subLen > $superLen) {
            return false;
        }

        $limit = $superLen - $subLen;

        for ($superIndex = 0; $superIndex <= $limit; $superIndex++) {
            if ($this->sliceMatchs($super, $superIndex, $sub)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Checks if a slice of `$source` starting at `$offset` matches the `$checked` array.
     *
     * This private helper function is used to compare a segment of the superlist
     * with the entire sublist.
     *
     * @param array $source The array from which to take a slice.
     * @param int $offset The starting index in `$source` for the slice.
     * @param array $checked The array to compare against the slice.
     * @return bool True if the slice from `$source` matches `$checked`, false otherwise.
     */
    private function sliceMatchs(array $source, int $offset, array $checked): bool
    {
        $top = count($checked);

        for ($index = 0; $index < $top; $index++) {
            if ($source[$offset + $index] !== $checked[$index]) {
                return false;
            }
        }

        return true;
    }
}