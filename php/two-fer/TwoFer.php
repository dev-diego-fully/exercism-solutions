<?php

declare(strict_types=1);

/**
 * Generates a "two-for-one" phrase.
 *
 * This function creates a simple phrase indicating an item is for a given person and for the speaker.
 * If no name is provided, it defaults to "you".
 *
 * @param string $name The name of the person for whom the item is intended. Defaults to "you".
 * @return string The formatted "one for [name], one for me" string.
 *
 * @example
 * twoFer();        // Returns "One for you, one for me."
 * twoFer('Alice'); // Returns "One for Alice, one for me."
 * twoFer('Bob');   // Returns "One for Bob, one for me."
 */
function twoFer(string $name = "you"): string
{
    return "One for $name, one for me.";
}