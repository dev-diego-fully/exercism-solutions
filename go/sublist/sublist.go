// package sublist provides functions to determine the relationship between
// two lists. It can check if one list is a
// sublist, superlist, equal, or unequal of the other.
package sublist

// Sublist determines the relationship between two lists: whether one is a
// sublist of the other, a superlist, equal, or unequal.
func Sublist(l1, l2 []int) Relation {
	isSub := isSubList(l1, l2)
	isSuper := isSubList(l2, l1)

	if isSub && isSuper {
		return RelationEqual
	}
	if isSuper {
		return RelationSuperlist
	}
	if isSub {
		return RelationSublist
	}
	return RelationUnequal
}

// isSubList checks if the first list is a sublist of the second list.
func isSubList(sub, super []int) bool {
	superLimit := len(super) - len(sub)
	if superLimit < 0 {
		return false
	}
	for i := 0; i <= superLimit; i++ {
		if match(super, sub, i) {
			return true
		}
	}
	return false
}

// match checks if a portion of the super list, starting at superStart,
// matches the sublist.
func match(super, sub []int, superStart int) bool {
	for i := 0; i < len(sub); i++ {
		if super[superStart+i] != sub[i] {
			return false
		}
	}
	return true
}
