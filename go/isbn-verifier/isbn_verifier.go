// package isbn provides a function to check whether an isbn in any
// common format is a valid isbn or not.
package isbn

// IsValidISBN Returns whether or not the given string is a valid
// isbn, in any format.
func IsValidISBN(isbn string) bool {
	if hasInvalidISBNRune(isbn) {
		return false
	}

	cleaned := cleanISBN(isbn)

	if !hasISBNFormat(cleaned) {
		return false
	}

	return hasValidCheckSum(cleaned)
}
