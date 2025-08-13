--- The public interface for a doubly linked list data structure.
--- @class LinkedList
local LinkedList <const> = {}

--- The internal implementation and data storage for a doubly linked list.
--- @class OwnerLinkedList : LinkedList
--- @field _head Node | nil The first node in the list.
--- @field _tail Node | nil The last node in the list.
--- @field _count integer The number of elements in the list.
local OwnerLinkedList <const> = {}

--- Represents a single element (node) in a linked list.
--- @class Node
--- @field value any The value stored in the node.
--- @field prev Node The previous node in the list.
--- @field next Node The next node in the list.
local Node <const> = {}

--- Creates a new empty doubly linked list.
--- @generic T The type of elements to be stored in the list.
--- @return LinkedList<T> -- A new list instance.
function LinkedList.new()
    return OwnerLinkedList.new()
end

--- Adds an element to the end of the list.
--- @generic T
--- @param self LinkedList<T>
--- @param element T The element to add.
function LinkedList.push(self, element)
    local owner = OwnerLinkedList.as_owner(self)

    owner._count = owner._count + 1

    if owner._tail == nil then
        owner._tail = Node.new(element, nil, nil)
        owner._head = owner._tail
    else
        owner._tail.next = Node.new(element, owner._tail, nil)
        owner._tail = owner._tail.next
    end
end

--- Removes and returns the element at the end of the list.
--- @generic T
--- @param self LinkedList<T>
--- @return T -- The element that was at the end of the list.
function LinkedList.pop(self)
    local owner = OwnerLinkedList.as_owner(self)

    if owner._tail == nil then
        error("can't pop from empty list")
    end

    owner._count = owner._count - 1
    local popped = owner._tail.value

    if owner._tail == owner._head then
        owner._tail = nil
        owner._head = nil
    else
        owner._tail = owner._tail.prev
        owner._tail.next = nil
    end

    return popped
end

--- Adds an element to the beginning of the list.
--- @generic T
--- @param self LinkedList<T>
--- @param element T The element to add.
function LinkedList.unshift(self, element)
    local owner = OwnerLinkedList.as_owner(self)

    owner._count = owner._count + 1

    if owner._head == nil then
        owner._head = Node.new(element, nil, nil)
        owner._tail = owner._head
    else
        owner._head.prev = Node.new(element, nil, owner._head)
        owner._head = owner._head.prev
    end
end

--- Removes and returns the element at the beginning of the list.
--- @generic T
--- @param self LinkedList<T>
--- @return T -- The element that was at the beginning of the list.
function LinkedList.shift(self)
    local owner = OwnerLinkedList.as_owner(self)

    if owner._head == nil then
        error("can't shift from empty list")
    end

    owner._count = owner._count - 1
    local unshifted = owner._head.value

    if owner._head == owner._tail then
        owner._head = nil
        owner._tail = nil
    else
        owner._head = owner._head.next
        owner._head.prev = nil
    end

    return unshifted
end

--- Returns the number of elements in the list.
--- @generic T
--- @param self LinkedList<T>
--- @return integer -- The count of elements.
function LinkedList.count(self)
    return OwnerLinkedList.as_owner(self)._count
end

--- Deletes the first occurrence of a given element from the list.
--- @generic T
--- @param self LinkedList<T>
--- @param element T The element to delete.
function LinkedList.delete(self, element)
    local owner = OwnerLinkedList.as_owner(self)

    local current = owner._head
    while current ~= nil do
        if current.value == element then
            if current.prev ~= nil then
                current.prev.next = current.next
            else
                owner._head = current.next
            end
            if current.next ~= nil then
                current.next.prev = current.prev
            else
                owner._tail = current.prev
            end
            owner._count = owner._count - 1
            break
        else
            current = current.next
        end
    end
end

LinkedList.__index = LinkedList

--- The internal constructor for a new OwnerLinkedList instance.
--- @generic T
--- @return OwnerLinkedList<T>
function OwnerLinkedList.new()
    return setmetatable(
        {
            _head = nil,
            _tail = nil,
            _count = 0
        },
        LinkedList
    )
end

--- Performs a type cast to the internal representation of the list.
--- @generic T
--- @param list LinkedList<T>
--- @return OwnerLinkedList<T> -- The internal list object.
function OwnerLinkedList.as_owner(list)
    return list
end

--- Creates a new Node instance.
--- @generic T
--- @param value T The value for the new node.
--- @param prev Node<T> The previous node.
--- @param next Node<T> The next node.
--- @return Node<T> -- The new node instance.
function Node.new(value, prev, next)
    return {
        value = value,
        prev = prev,
        next = next
    }
end

return LinkedList.new