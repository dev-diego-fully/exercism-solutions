<?php

class HighSchoolSweetheart
{
    public function firstLetter(string $name): string
    {
        return substr(trim($name), 0, 1);
    }

    public function initial(string $name): string
    {
        $first = strtoupper($this->firstLetter($name));
        return "$first.";
    }

    public function initials(string $name): string
    {
        $names = preg_split("/\s/", $name);
        $initial1 = $this->initial($names[0]);
        $initial2 = $this->initial($names[1]);
        return "$initial1 $initial2";
    }

    public function pair(string $sweetheart_a, string $sweetheart_b): string
    {
        $i1 = $this->initials($sweetheart_a);
        $i2 = $this->initials($sweetheart_b);
        return <<<EOD
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     $i1  +  $i2     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
EOD;


    }
}
