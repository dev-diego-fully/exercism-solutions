package react

// cell is a reactive unit that holds a value and a collection of callbacks.
// The value can be updated by a direct setter or a compute function.
type cell struct {
	ownerReactor      *reactor
	id                uint
	cellValue         int
	callbacks         map[uint]*callback
	currentCallbackId uint
	updateGetter      func() int
}

// newCell creates a new cell instance.
func newCell(ownerReactor *reactor, id uint, initial int, updateGetter func() int) *cell {
	return &cell{
		ownerReactor:      ownerReactor,
		id:                id,
		cellValue:         initial,
		callbacks:         map[uint]*callback{},
		currentCallbackId: 0,
		updateGetter:      updateGetter,
	}
}

// Value returns the current integer value of the cell.
func (c *cell) Value() int {
	return c.cellValue
}

// SetValue updates the cell's value and triggers updates for its dependents
// and callbacks if the value has changed.
func (c *cell) SetValue(value int) {
	if c.Value() != value {
		c.cellValue = value
		c.handleDependents()
		c.handleCallbacks()
	}
}

// AddCallback registers a callback function to be executed when the cell's
// value changes. It returns a Canceler that can be used to unregister the callback.
func (c *cell) AddCallback(callback func(int)) Canceler {
	warpCallback := newCallback(
		c, c.provideCallbackId(), callback,
	)

	c.callbacks[warpCallback.id] = &warpCallback
	canceler := cancelerFor(&warpCallback)

	return &canceler
}

// handleCallbacks adds all of the cell's registered callbacks to the reactor's queue for execution.
func (c *cell) handleCallbacks() {
	for _, callback := range c.callbacks {
		c.ownerReactor.enqueueCallback(callback)
	}
}

// handleDependents adds all of the cell's dependent cells to the reactor's update queue.
func (c *cell) handleDependents() {
	c.ownerReactor.updateDependents(c)
}

// removeCallback unregisters a callback from the cell using its ID.
func (c *cell) removeCallback(aCallback *callback) {
	delete(c.callbacks, aCallback.id)
}

// refreshCell updates the cell's value by calling its updateGetter function.
func (c *cell) refreshCell() {
	c.SetValue(c.updateGetter())
}

// provideCallbackId generates a new, unique ID for a callback.
func (c *cell) provideCallbackId() uint {
	id := c.currentCallbackId
	c.currentCallbackId++
	return id
}

// singleUpdateGetter creates an update function for a compute cell with a single dependency.
func singleUpdateGetter(dep Cell, compute func(int) int) func() int {
	return func() int {
		return compute(dep.Value())
	}
}

// doublyUpdateGetter creates an update function for a compute cell with two dependencies.
func doublyUpdateGetter(dep1, dep2 Cell, compute func(int, int) int) func() int {
	return func() int {
		return compute(dep1.Value(), dep2.Value())
	}
}
