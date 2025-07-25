<?php

declare(strict_types=1);

/**
 * MicroBlog
 *
 * This class provides functionality for a micro-blogging platform,
 * specifically for truncating text to a fixed length.
 */
class MicroBlog
{
    /**
     * Truncates a given string to a maximum length of 5 characters.
     *
     * This method is designed to handle multi-byte characters correctly,
     * ensuring that characters like emojis or those from non-Latin alphabets
     * are counted as a single character.
     *
     * @param string $text The input string to be truncated.
     * @return string The truncated string, with a maximum length of 5 characters.
     *
     * @example
     * (new MicroBlog())->truncate('Hi');               // Returns "Hi"
     * (new MicroBlog())->truncate('Hello there');      // Returns "Hello"
     * (new MicroBlog())->truncate('brühe');            // Returns "brühe"
     * (new MicroBlog())->truncate('Bärteppich');       // Returns "Bärte"
     * (new MicroBlog())->truncate('Добър');            // Returns "Добър"
     * (new MicroBlog())->truncate('❄🌡🤧🤒🏥🕰😀'); // Returns "❄🌡🤧🤒🏥"
     * (new MicroBlog())->truncate('🃎🂸🃅🃋🃍🃁🃊'); // Returns "🃎🂸🃅🃋🃍"
     */
    public function truncate(string $text): string
    {
        return mb_substr($text, 0, 5);
    }
}