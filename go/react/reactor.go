package react

// reactor is the core of the reactive system, managing cells, dependencies, and update queues.
type reactor struct {
	currentInputCellId uint
	dependenciesMap    map[uint][]*cell
	updateQueue        queue[*cell]
	isUpdating         bool
	callbackQueue      queue[*callback]
}

// New creates and returns a new Reactor instance.
func New() Reactor {
	return &reactor{
		currentInputCellId: 0,
		dependenciesMap:    map[uint][]*cell{},
		updateQueue:        queue[*cell]{},
		isUpdating:         false,
		callbackQueue:      queue[*callback]{},
	}
}

// CreateInput creates a new input cell with an initial value.
func (r *reactor) CreateInput(initial int) InputCell {
	cell := newCell(r, r.provideCellId(), initial, nil)

	return cell
}

// CreateCompute1 creates a new compute cell with one dependency.
func (r *reactor) CreateCompute1(dep Cell, compute func(int) int) ComputeCell {
	depCell, ok := dep.(*cell)

	if !ok {
		return nil
	}

	updateGetter := singleUpdateGetter(dep, compute)

	computeCell := newCell(r, r.provideCellId(), updateGetter(), updateGetter)

	r.menageDependency(depCell, computeCell)

	return computeCell
}

// CreateCompute2 creates a new compute cell with two dependencies.
func (r *reactor) CreateCompute2(dep1, dep2 Cell, compute func(int, int) int) ComputeCell {
	dep1ConcreteCell, dep1Ok := dep1.(*cell)
	dep2ConcreteCell, dep2Ok := dep2.(*cell)

	if !dep1Ok || !dep2Ok {
		return nil
	}

	updateGetter := doublyUpdateGetter(dep1, dep2, compute)
	computeCell := newCell(
		r, r.provideCellId(), updateGetter(), updateGetter,
	)

	r.menageDependency(dep1ConcreteCell, computeCell)
	r.menageDependency(dep2ConcreteCell, computeCell)

	return computeCell
}

// provideCellId generates a new, unique ID for a cell.
func (r *reactor) provideCellId() uint {
	id := r.currentInputCellId
	r.currentInputCellId++
	return id
}

// menageDependency records a dependency relationship between two cells.
func (r *reactor) menageDependency(dependency *cell, dependent *cell) {
	r.dependenciesMap[dependency.id] = append(
		r.dependenciesMap[dependency.id], dependent,
	)
}

// updateDependents orchestrates the update cycle for all cells and their callbacks.
func (r *reactor) updateDependents(dependency *cell) {
	for _, dependent := range r.dependenciesMap[dependency.id] {
		r.updateQueue.add(dependent)
	}

	if r.isUpdating {
		return
	}

	r.isUpdating = true

	for !r.updateQueue.isEmpty() {
		cell, _ := r.updateQueue.get()
		cell.refreshCell()
	}

	r.isUpdating = false

	for !r.callbackQueue.isEmpty() {
		callback, _ := r.callbackQueue.get()
		callback.run()
	}
}

// enqueueCallback adds a callback to the queue to be executed after the current update cycle.
func (r *reactor) enqueueCallback(toRun *callback) {
	r.callbackQueue.add(toRun)
}
