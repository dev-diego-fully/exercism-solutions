// Package letter provides functions for counting the frequency of runes
// in strings, including a concurrent implementation.
package letter

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(texts []string) FreqMap {
	frequenciesChan := make(chan FreqMap, max(len(texts), 2))
	frequencies := FreqMap{}

	for _, text := range texts {
		go parallelCount(text, frequenciesChan)
	}

	for range texts {
		merge(&frequencies, <-frequenciesChan)
	}

	return frequencies
}

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(text string) FreqMap {
	frequencies := FreqMap{}
	for _, r := range text {
		frequencies[r]++
	}
	return frequencies
}

// merge combines the rune counts from a new FreqMap into an existing one.
func merge(old *FreqMap, news FreqMap) {
	for letter, count := range news {
		(*old)[letter] += count
	}
}

// parallelCount counts the frequency of runes in a text and sends the result to a channel.
func parallelCount(text string, output chan FreqMap) {
	output <- Frequency(text)
}

// max returns the larger of two integers.
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
