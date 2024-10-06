<?php

class PizzaPi
{
    public function calculateDoughRequirement(int $pizzas, int $persons)
    {
        $min_dough = 200;
        $dough_per_person = 20;

        return $pizzas * (($persons * $dough_per_person) + $min_dough);
    }

    public function calculateSauceRequirement(int $pizzas, float $souce_can_volume)
    {
        $souce_per_pizza = 125;

        return $pizzas * $souce_per_pizza / $souce_can_volume;
    }

    public function calculateCheeseCubeCoverage(float $cheese_dimension, float $thickness, float $diameter)
    {
        return floor($cheese_dimension ** 3 / ($thickness * pi() * $diameter));
    }

    public function calculateLeftOverSlices(int $pizzas, int $friends)
    {
        $slice_per_pizza = 8;
        return $pizzas * $slice_per_pizza % $friends;
    }
}
