package gigasecond

import "time"

// AddGigasecond should have a comment documenting it.
func AddGigasecond(t time.Time) time.Time {
	var gigasecond = time.Second * 1_000_000_000
	return t.Add(gigasecond)
}
