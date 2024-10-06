<?php

class Lasagna
{
    public function expectedCookTime()
    {
        $time_in_minutes = 40;
        return $time_in_minutes;
    }

    public function remainingCookTime($elapsed_minutes)
    {
        $min_minutes = 0;
        return max($this->expectedCookTime() - $elapsed_minutes, $min_minutes);
    }

    public function totalPreparationTime($layers_to_prep)
    {
        $minutes_per_layer = 2;
        return $layers_to_prep * $minutes_per_layer;
    }

    public function totalElapsedTime($layers_to_prep, $elapsed_minutes)
    {
        return $this->totalPreparationTime($layers_to_prep) + $elapsed_minutes;
    }

    public function alarm()
    {
        $alarm_sound = "Ding!";
        return $alarm_sound;
    }
}
