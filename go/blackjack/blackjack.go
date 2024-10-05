package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "two":
		return 2
	case "three":
		return 3
	case "four":
		return 4
	case "five":
		return 5
	case "six":
		return 6
	case "seven":
		return 7
	case "eight":
		return 8
	case "nine":
		return 9
	case "ten", "jack", "queen", "king":
		return 10
	default:
		return 0
	}
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	const split, stand, autoWin, hit = "P", "S", "W", "H"
	var valCard1, valCard2 = ParseCard(card1), ParseCard(card2)
	var valDealerCard = ParseCard(dealerCard)

	switch {
	case card1 == "ace" && card2 == "ace":
		return split
	case valCard1+valCard2 == 21 && valDealerCard < 10:
		return autoWin
	case valCard1+valCard2 == 21:
		return stand
	case valCard1+valCard2 <= 11:
		return hit
	case valCard1+valCard2 >= 17:
		return stand
	case valDealerCard >= 7:
		return hit
	default:
		return stand
	}
}
