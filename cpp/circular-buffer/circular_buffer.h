/**
 * @file circular_buffer.h
 * @brief Implements a generic circular buffer.
 *
 * This file defines a templated circular buffer class, which provides
 * a fixed-size, FIFO (First-In-First-Out) buffer with support for
 * writing, reading, overwriting, and clearing operations.
 */

#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H

#include <vector>
#include <stdexcept>

namespace circular_buffer
{
    /**
     * @brief A templated circular buffer implementation.
     *
     * This class implements a circular buffer that allows elements to be
     * written, read, and overwritten when full. It provides efficient
     * FIFO storage with constant-time operations.
     *
     * @tparam T The type of elements stored in the buffer.
     */
    template <typename T>
    class circular_buffer
    {
    private:
        std::vector<T> elements;
        size_t elements_count = 0;
        size_t writer_position = 0;
        size_t reader_position = 0;
        size_t size;

        /**
         * @brief Advances the reader position cyclically.
         */
        void advance_reader_position()
        {
            this->reader_position = (this->reader_position + 1) % this->size;
        }

        /**
         * @brief Advances the writer position cyclically.
         */
        void advance_writer_position()
        {
            this->writer_position = (this->writer_position + 1) % this->size;
        }

        /**
         * @brief Checks if the buffer is full.
         * @return True if the buffer is full, false otherwise.
         */
        bool is_full()
        {
            return !(this->elements_count < this->size);
        }

        /**
         * @brief Checks if the buffer is empty.
         * @return True if the buffer is empty, false otherwise.
         */
        bool is_empty()
        {
            return this->elements_count < 1;
        }

    public:
        /**
         * @brief Constructs a circular buffer with a specified size.
         *
         * @param size The maximum number of elements the buffer can hold.
         */
        circular_buffer(size_t size)
        {
            this->elements = std::vector<T>(size);
            this->size = size;
        }

        /**
         * @brief Reads and removes the oldest element from the buffer.
         *
         * @return The oldest element in the buffer.
         * @throws std::domain_error if the buffer is empty.
         */
        T read()
        {
            if (this->is_empty())
            {
                throw std::domain_error("can't read from empty buffer");
            }
            T readed = this->elements.at(this->reader_position);

            this->advance_reader_position();
            this->elements_count--;
            return readed;
        }

        /**
         * @brief Writes a new element to the buffer.
         *
         * @param element The element to write.
         * @throws std::domain_error if the buffer is full.
         */
        void write(T element)
        {
            if (this->is_full())
            {
                throw std::domain_error("can't write in a full buffer");
            }
            this->elements[this->writer_position] = element;
            this->advance_writer_position();
            this->elements_count++;
        }

        /**
         * @brief Writes a new element to the buffer, overwriting the oldest one if full.
         *
         * If the buffer is full, the oldest element is removed to make space for the new one.
         * Otherwise, the element is simply added to the buffer.
         *
         * @param element The element to write.
         */
        void overwrite(T element)
        {
            this->elements[this->writer_position] = element;
            this->advance_writer_position();

            if (this->is_full())
            {
                this->advance_reader_position();
            }
            else
            {
                this->elements_count++;
            }
        }

        /**
         * @brief Clears all elements from the buffer.
         *
         * The buffer will be empty after calling this method.
         */
        void clear()
        {
            this->elements_count = 0;
        }
    };

} // namespace circular_buffer

#endif // CIRCULAR_BUFFER_H