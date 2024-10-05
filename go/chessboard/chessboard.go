package chessboard

type File []bool
type Chessboard map[string]File

var fileIndexes = []string{"A", "B", "C", "D", "E", "F", "G", "H"}

// CountInFile returns how many squares are occupied in the chessboard,
// within the given file.
func CountInFile(cb Chessboard, file string) int {
	fileContent, fileExist := cb[file]

	if !fileExist {
		return 0
	}

	count := 0

	for _, occupied := range fileContent {
		if occupied {
			count += 1
		}
	}

	return count
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank.
func CountInRank(cb Chessboard, rank int) int {

	if rank < 1 || rank > 8 {
		return 0
	}

	var rankIndex = rank - 1
	var count int = 0

	for _, fileIndex := range fileIndexes {
		file, fileExist := cb[fileIndex]
		if !fileExist {
			return 0
		}

		occupied := file[rankIndex]
		if occupied {
			count += 1
		}
	}

	return count
}

// CountAll should count how many squares are present in the chessboard.
func CountAll(cb Chessboard) int {
	count := 0

	for _, file := range cb {
		count += len(file)
	}

	return count
}

// CountOccupied returns how many squares are occupied in the chessboard.
func CountOccupied(cb Chessboard) int {
	count := 0

	for _, fileIndex := range fileIndexes {
		count += CountInFile(cb, fileIndex)
	}

	return count
}
