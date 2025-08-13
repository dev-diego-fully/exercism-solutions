local proxy

--- Implements a mathematical set data structure.
--- @class Set
local Set <const> = {}

--- Creates a new Set instance.
--- This is a factory function that creates a new table with proxied methods.
--- @generic T The type of elements in the set.
--- @param ... T A list of initial elements for the set.
--- @return Set<T> -- A new Set instance.
function Set.new(...)
    local inner = {}

    for _, element in pairs({ ... }) do
        inner[element] = true
    end

    local set = {
        is_empty = proxy(Set.is_empty, inner),
        is_subset = proxy(Set.is_subset, inner),
        is_disjoint = proxy(Set.is_disjoint, inner),
        equals = proxy(Set.equals, inner),
        values = proxy(Set.values, inner),
        contains = proxy(Set.contains, inner),
        add = proxy(Set.add, inner),
        intersection = proxy(Set.intersection, inner),
        difference = proxy(Set.difference, inner),
        union = proxy(Set.union, inner)
    }

    return set
end

--- Checks if an element is a member of the set.
--- @generic T
--- @param self Set<T> The set instance.
--- @param element T The element to check for.
--- @return boolean -- True if the element is in the set, false otherwise.
function Set.contains(self, element)
    return self[element] == true
end

--- Adds an element to the set.
--- @generic T
--- @param self Set<T> The set instance.
--- @param element T The element to add.
function Set.add(self, element)
    self[element] = true
end

--- Checks if the set is empty.
--- @generic T
--- @param self Set<T> The set instance.
--- @return boolean -- True if the set has no elements, false otherwise.
function Set.is_empty(self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

--- Checks if the current set is a subset of another set.
--- @generic T
--- @param self Set<T> The set instance.
--- @param other Set<T> The other set to compare against.
--- @return boolean -- True if all elements of the current set are in the other set.
function Set.is_subset(self, other)
    if Set.is_empty(self) then
        return true
    end
    if other:is_empty() then
        return false
    end
    for element, _ in pairs(self) do
        if not other:contains(element) then
            return false
        end
    end
    return true
end

--- Checks if two sets are disjoint (have no common elements).
--- @generic T
--- @param self Set<T> The set instance.
--- @param other Set<T> The other set to compare against.
--- @return boolean -- True if the sets have no elements in common.
function Set.is_disjoint(self, other)
    for element, _ in pairs(self) do
        if other:contains(element) then
            return false
        end
    end
    return true
end

--- Computes the intersection of two sets.
--- @generic T
--- @param self Set<T> The set instance.
--- @param other Set<T> The other set to intersect with.
--- @return Set<T> -- A new set containing only the elements common to both sets.
function Set.intersection(self, other)
    local inter = Set.new()

    for element, _ in pairs(self) do
        if other:contains(element) then
            inter:add(element)
        end
    end

    return inter
end

--- Computes the difference between two sets.
--- @generic T
--- @param self Set<T> The set instance.
--- @param other Set<T> The other set to subtract.
--- @return Set<T> -- A new set containing elements that are in the first set but not the second.
function Set.difference(self, other)
    local diff = Set.new()

    for element, _ in pairs(self) do
        if not other:contains(element) then
            diff:add(element)
        end
    end

    return diff
end

--- Computes the union of two sets.
--- @generic T
--- @param self Set<T> The set instance.
--- @param other Set<T> The other set to union with.
--- @return Set<T> -- A new set containing all unique elements from both sets.
function Set.union(self, other)
    local union = Set.new(table.unpack(other:values()))

    for element, _ in pairs(self) do
        union:add(element)
    end

    return union
end

--- Checks if two sets are equal.
--- Two sets are equal if they contain the exact same elements.
--- @generic T
--- @param self Set<T> The set instance.
--- @param other Set<T> The other set to compare against.
--- @return boolean -- True if the sets are equal, false otherwise.
function Set.equals(self, other)
    return Set.union(self, other)
        :difference(Set.intersection(self, other))
        :is_empty()
end

--- Returns a table of the set's elements.
--- The order of elements is not guaranteed.
--- @generic T
--- @param self Set<T> The set instance.
--- @return T[] -- A table containing the elements of the set.
function Set.values(self)
    local vals = {}

    for element, _ in pairs(self) do
        table.insert(vals, element)
    end

    return vals
end

--- Creates a closure that acts as a proxy for a function, binding it to a specific inner table.
--- @param fn function The function to proxy.
--- @param inner any The inner table to which the function will be bound.
--- @return function -- A new function that calls the original with the inner table as the first argument.
function proxy(fn, inner)
    return function(_, ...)
        return fn(inner, ...)
    end
end

return Set.new