--- A public interface for a circular buffer data structure.
--- @class CircularBuffer
local CircularBuffer <const> = {}

--- The internal implementation of a circular buffer, holding its state.
--- @class PrivCircularBuffer : CircularBuffer
--- @field _elements string[] The internal table that stores the buffer's elements.
--- @field _size integer The maximum capacity of the buffer.
--- @field _count integer The current number of elements in the buffer.
--- @field _reader integer The index of the next element to be read.
--- @field _writer integer The index of the next position to be written to.
local PrivCircularBuffer <const> = {}

--- Creates a new CircularBuffer instance with a specified size.
--- @param size integer The maximum capacity of the buffer.
--- @return CircularBuffer -- The new circular buffer instance.
function CircularBuffer:new(size)
    return PrivCircularBuffer.new(size)
end

--- Writes an element to the buffer.
--- If the buffer is full, an error will be thrown. Null elements are ignored.
--- @generic T
--- @param self CircularBuffer<T>
--- @param element T The element to write.
--- @return CircularBuffer<T> -- The updated buffer instance.
function CircularBuffer.write(self, element)
    ---@cast self PrivCircularBuffer

    assert(not self:_isFull(), "buffer is full")

    if element == nil then
        return self
    end

    self._elements[self._writer] = element

    self:_advanceWriter()
    self:_incrementCount()
    
    return self
end

--- Forcibly writes an element to the buffer, overwriting the oldest element if the buffer is full.
--- Null elements are ignored.
--- @generic T
--- @param self CircularBuffer<T>
--- @param element T The element to write.
--- @return CircularBuffer<T> -- The updated buffer instance.
function CircularBuffer.forceWrite(self, element)
    ---@cast self PrivCircularBuffer
    if element == nil then
        return self
    end

    self._elements[self._writer] = element

    if self:_isFull() then
        self:_advanceReader()
    else
        self:_incrementCount()
    end

    self:_advanceWriter()
    
    return self
end

--- Reads and returns the oldest element from the buffer.
--- An error is thrown if the buffer is empty.
--- @generic T
--- @param self CircularBuffer<T>
--- @return T -- The oldest element in the buffer.
function CircularBuffer.read(self)
    ---@cast self PrivCircularBuffer
    
    assert(not self:_isEmpty(), "buffer is empty")

    local readed = self._elements[self._reader]
    self:_advanceReader()
    self:_decrementCount()

    return readed
end

--- Clears the buffer, resetting its state to empty.
--- @generic T
--- @param self CircularBuffer<T>
--- @return CircularBuffer<T> -- The cleared buffer instance.
function CircularBuffer.clear(self)
    ---@cast self PrivCircularBuffer
    self._count = 0
    self._writer = 1
    self._reader = 1

    return self
end

--- The __index metamethod for PrivCircularBuffer.
--- It allows instances of PrivCircularBuffer to access methods defined in the CircularBuffer table.
--- @param tab table The instance table.
--- @param index any The key being accessed.
--- @return any -- The value from the CircularBuffer table or nil.
PrivCircularBuffer.__index = function(tab, index)
    return CircularBuffer[index] or PrivCircularBuffer[index]
end

--- The internal constructor for a new PrivCircularBuffer instance.
--- @param size integer The size of the buffer.
--- @return PrivCircularBuffer -- The new PrivCircularBuffer instance.
function PrivCircularBuffer.new(size)
    return setmetatable(
        {
            _elements = {},
            _count = 0,
            _reader = 1,
            _writer = 1,
            _size = size
        },
        PrivCircularBuffer
    )
end

--- Checks if the buffer is currently full.
--- @param self PrivCircularBuffer
--- @return boolean -- True if the number of elements equals the size, false otherwise.
function PrivCircularBuffer._isFull(self)
    return self._count >= self._size
end

--- Checks if the buffer is currently empty.
--- @param self PrivCircularBuffer
--- @return boolean -- True if the buffer contains no elements, false otherwise.
function PrivCircularBuffer._isEmpty(self)
    return self._count == 0
end

--- Advances the reader index for the next read operation.
--- This is an internal helper function.
--- @param self PrivCircularBuffer
function PrivCircularBuffer._advanceReader(self)
    local next = (self._reader + 1) % (self._size + 1)
    self._reader = next
end

--- Advances the writer index for the next write operation.
--- This is an internal helper function.
--- @param self PrivCircularBuffer
function PrivCircularBuffer._advanceWriter(self)
    local next = (self._writer + 1) % (self._size + 1)
    self._writer = next
end

--- Increments the element count of the buffer.
--- This is an internal helper function.
--- @param self PrivCircularBuffer
function PrivCircularBuffer._incrementCount(self)
    self._count = self._count + 1
end

--- Decrements the element count of the buffer.
--- This is an internal helper function.
--- @param self PrivCircularBuffer
function PrivCircularBuffer._decrementCount(self)
    self._count = self._count - 1
end

return CircularBuffer