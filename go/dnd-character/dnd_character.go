package dndcharacter

import (
	"math/rand"
)

type Character struct {
	Strength     int
	Dexterity    int
	Constitution int
	Intelligence int
	Wisdom       int
	Charisma     int
	Hitpoints    int
}

// Modifier calculates the ability modifier for a given ability score
func Modifier(score int) int {
	return score/2 - 5
}

// Ability uses randomness to generate the score for an ability
func Ability() int {
	var r1, r2, r3, r4 int = d6(), d6(), d6(), d6()

	return r1 + r2 + r3 + r4 - min(r1, r2, r3, r4)
}

// GenerateCharacter creates a new Character with random scores for abilities
func GenerateCharacter() Character {
	char := Character{
		Strength:     Ability(),
		Dexterity:    Ability(),
		Constitution: Ability(),
		Intelligence: Ability(),
		Wisdom:       Ability(),
		Charisma:     Ability(),
	}
	char.Hitpoints = Modifier(char.Constitution) + 10
	return char
}

// d6 simulate a roll of a dice of 6 sides
func d6() int {
	return rand.Intn(6) + 1
}

func min(v1, v2, v3, v4 int) int {
	var lowerest = v1
	if v2 < lowerest {
		lowerest = v2
	}
	if v3 < lowerest {
		lowerest = v3
	}
	if v4 < lowerest {
		lowerest = v4
	}
	return lowerest
}
