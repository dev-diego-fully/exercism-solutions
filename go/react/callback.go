package react

// callback holds a function to be executed when a cell's value changes.
type callback struct {
	id         uint
	ownerCell  *cell
	lastValue  int
	callbackFn func(int)
}

// newCallback creates a new callback associated with a cell.
func newCallback(ownerCell *cell, id uint, callbackFn func(int)) callback {
	return callback{
		ownerCell: ownerCell, id: id, callbackFn: callbackFn, lastValue: ownerCell.Value(),
	}
}

// run executes the callback function if the owner cell's value has changed since the last run.
func (c *callback) run() {
	value := c.ownerCell.Value()
	if value != c.lastValue {
		c.callbackFn(value)
		c.lastValue = value
	}
}

// canceler provides a way to remove a registered callback.
type canceler struct {
	ownerCallback *callback
}

// cancelerFor creates a new canceler for a specific callback.
func cancelerFor(aCallback *callback) canceler {
	return canceler{ownerCallback: aCallback}
}

// Cancel removes the associated callback from its owner cell.
func (c *canceler) Cancel() {
	c.ownerCallback.ownerCell.removeCallback(c.ownerCallback)
}
