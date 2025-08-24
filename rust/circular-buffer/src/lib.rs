/// A generic, fixed-size circular buffer.
///
/// This data structure allows for efficient, continuous reading and writing of elements.
/// It uses a fixed-size vector with a writer head and a reader head that wrap around
/// to the beginning of the buffer.
pub struct CircularBuffer<T> {
    buffer: Vec<Option<T>>,
    writer: usize,
    reader: usize,
    count: usize,
}

/// An enumeration of possible errors for a `CircularBuffer` operation.
///
/// - `EmptyBuffer`: The buffer is empty and a read operation was attempted.
/// - `FullBuffer`: The buffer is full and a write operation was attempted.
#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T> CircularBuffer<T> {
    /// Creates a new `CircularBuffer` with a specified capacity.
    ///
    /// The buffer is initialized with `None` values and both the reader and writer
    /// heads are set to the start of the buffer.
    pub fn new(capacity: usize) -> Self {
        Self {
            buffer: (0..capacity).map(|_| Option::None).collect(),
            reader: 0,
            writer: 0,
            count: 0,
        }
    }

    /// Writes an element to the buffer.
    ///
    /// If the buffer is not full, the element is added to the next available slot.
    /// Returns `Ok(())` on success or an `Err(Error::FullBuffer)` if the buffer is full.
    pub fn write(&mut self, element: T) -> Result<(), Error> {
        if self.is_inner_buffer_full() {
            return Err(Error::FullBuffer);
        }
        self.push_to_inner_buffer(element);
        Ok(())
    }

    /// Reads the oldest element from the buffer.
    ///
    /// If the buffer is not empty, it removes and returns the next element to be read.
    /// Returns `Ok(T)` on success or an `Err(Error::EmptyBuffer)` if the buffer is empty.
    pub fn read(&mut self) -> Result<T, Error> {
        if self.is_inner_buffer_empty() {
            return Err(Error::EmptyBuffer);
        }
        Ok(self.pop_from_inner_buffer())
    }

    /// Clears the buffer, resetting it to an empty state.
    ///
    /// This method resets all internal state variables and replaces all elements
    /// with `None`, effectively making the buffer empty and ready for new data.
    pub fn clear(&mut self) {
        (self.count, self.writer, self.reader) = (0, 0, 0);
        self.buffer = (0..self.buffer.len()).map(|_| None).collect();
    }

    /// Overwrites the oldest element in the buffer with a new one if the buffer is full.
    ///
    /// If the buffer is full, the element at the reader's head is replaced, and the
    /// reader head is advanced. If the buffer is not full, the element is simply
    /// appended to the end.
    pub fn overwrite(&mut self, element: T) {
        if self.is_inner_buffer_full() {
            self.advance_reader_head();
        }
        self.push_to_inner_buffer(element);
    }
}

impl<T> CircularBuffer<T> {
    /// Checks if the internal buffer is full.
    fn is_inner_buffer_full(&self) -> bool {
        self.count == self.buffer.len()
    }

    /// Checks if the internal buffer is empty.
    fn is_inner_buffer_empty(&self) -> bool {
        self.count == 0
    }

    /// Pushes an element into the internal buffer at the writer's head.
    ///
    /// This is a core helper method that handles the logic of inserting a new element,
    /// updating the element count, and advancing the writer head.
    fn push_to_inner_buffer(&mut self, element: T) {
        self.buffer[self.writer].replace(element);
        self.count = usize::min(self.count + 1, self.buffer.len());
        self.advance_writer_head();
    }

    /// Pops an element from the internal buffer at the reader's head.
    ///
    /// This is a core helper method that handles the logic of removing the oldest element,
    /// decrementing the element count, and advancing the reader head.
    fn pop_from_inner_buffer(&mut self) -> T {
        self.count -= 1;
        let readed = self.buffer[self.reader].take().unwrap();
        self.advance_reader_head();
        readed
    }

    /// Advances the writer head to the next position, wrapping around if necessary.
    fn advance_writer_head(&mut self) {
        self.writer = (self.writer + 1) % self.buffer.len();
    }

    /// Advances the reader head to the next position, wrapping around if necessary.
    fn advance_reader_head(&mut self) {
        self.reader = (self.reader + 1) % self.buffer.len();
    }
}