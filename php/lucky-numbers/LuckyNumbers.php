<?php

class LuckyNumbers
{
    public function sumUp(array $digitsOfNumber1, array $digitsOfNumber2): int
    {
        $a = implode("", $digitsOfNumber1);
        $b = implode("", $digitsOfNumber2);
        return (int)$a + (int)$b;
    }

    public function isPalindrome(int $number): bool
    {
        $str_num = (string)$number;
        $digits_count = strlen($str_num);
        for( $i = 0; $i < $digits_count; $i++ ) {
            if($str_num[$i] != $str_num[$digits_count - 1 - $i]) {
                return false;
            }
        }
        return true;
    }

    public function validate(string $input): string
    {
        if($input == "") {
            return "Required field";
        }
        try {
            $converted_input = (int)$input;
            if($converted_input <= 0) {
                return 'Must be a whole number larger than 0';
            }
            return "";
        } catch(e) {
            return "Required field";
        }
    }
}
