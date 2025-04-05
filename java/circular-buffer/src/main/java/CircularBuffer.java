import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class CircularBuffer<T> {

    private final List<T> buffer;
    private int count;
    private int reader;
    private int writer;

    CircularBuffer(final int size) {
        this.buffer = new ArrayList<>(Collections.nCopies(size, null));
        this.count = 0;
        this.reader = 0;
        this.writer = 0;
    }

    T read() throws BufferIOException {
        if (this.isEmpty()) {
            throw new BufferIOException("Tried to read from empty buffer");
        }
        this.count--;

        final T readed = this.buffer.get(this.reader);
        this.advanceReader();

        return readed;
    }

    void write(T data) throws BufferIOException {
        if (this.isFull()) {
            throw new BufferIOException("Tried to write to full buffer");
        }
        this.count++;

        this.buffer.set(this.writer, data);
        this.advanceWriter();
    }

    void overwrite(T data) {
        this.buffer.set(this.writer, data);
        this.advanceWriter();

        if (this.isFull()) {
            this.advanceReader();
            return;
        }

        this.count++;
    }

    void clear() {
        this.count = 0;
        this.reader = 0;
        this.writer = 0;
    }

    private void advanceReader() {
        this.reader = (this.reader + 1) % this.buffer.size();
    }

    private void advanceWriter() {
        this.writer = (this.writer + 1) % this.buffer.size();
    }

    private boolean isEmpty() {
        return this.count == 0;
    }

    private boolean isFull() {
        return this.count == this.buffer.size();
    }

}