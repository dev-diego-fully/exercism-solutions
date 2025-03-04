/**
 * @file linked_list.h
 * @brief Doubly linked list implementation with head/tail pointers
 */
#pragma once

#include <memory>
#include <stdexcept>

namespace linked_list
{

    /**
     * @brief Internal node structure for linked list
     * @tparam T Type of stored elements
     */
    template <typename T>
    class Node
    {
    public:
        std::shared_ptr<Node<T>> next;     ///< Pointer to next node
        std::shared_ptr<Node<T>> previous; ///< Pointer to previous node

        /**
         * @brief Constructs a new node
         * @param element Value to store
         * @param previous Previous node pointer
         * @param next Next node pointer
         */
        Node(T element, std::shared_ptr<Node<T>> previous, std::shared_ptr<Node<T>> next)
        {
            this->_value = element;
            this->previous = previous;
            this->next = next;
        }

        /// @brief Gets stored value
        T value() const
        {
            return this->_value;
        }

    private:
        T _value; ///< Contained value
    };

    /**
     * @brief Doubly linked list with O(1) push/pop at both ends
     * @tparam T Type of elements to store
     */
    template <typename T>
    class List
    {
    public:
        /**
         * @brief Adds element to the end of list
         * @param element Element to append
         */
        void push(T element)
        {
            if (this->tail == nullptr)
            {
                this->tail = std::make_shared<Node<T>>(element, nullptr, nullptr);
                this->head = this->tail;
            }
            else
            {
                this->tail->next = std::make_shared<Node<T>>(element, this->tail, nullptr);
                this->tail = this->tail->next;
            }
            this->_count++;
        }

        /**
         * @brief Removes and returns last element
         * @return Popped element
         * @throw std::domain_error If list is empty
         */
        T pop()
        {
            if (!this->tail)
                throw std::domain_error("can't pop from a empty list");

            T popped = this->tail->value();

            if (this->head == this->tail)
            {
                this->tail = nullptr;
                this->head = nullptr;
            }
            else
            {
                this->tail = this->tail->previous;
                this->tail->next = nullptr;
            }

            this->_count--;

            return popped;
        }

        /**
         * @brief Removes and returns first element
         * @return Shifted element
         * @throw std::domain_error If list is empty
         */
        T shift()
        {
            if (!this->head)
                throw std::domain_error("can't shift from a empty list");

            T shifted = this->head->value();

            if (this->head == this->tail)
            {
                this->head = nullptr;
                this->tail = nullptr;
            }
            else
            {
                this->head = this->head->next;
                this->head->previous = nullptr;
            }

            this->_count--;

            return shifted;
        }

        /**
         * @brief Adds element to the beginning of list
         * @param element Element to prepend
         */
        void unshift(T element)
        {
            if (this->head == nullptr)
            {
                this->head = std::make_shared<Node<T>>(element, nullptr, nullptr);
                this->tail = this->head;
            }
            else
            {
                this->head->previous = std::make_shared<Node<T>>(element, nullptr, this->head);
                this->head = this->head->previous;
            }

            this->_count++;
        }

        /// @brief Current number of elements
        size_t count() const
        {
            return this->_count;
        }

        /**
         * @brief Removes the first occurrence of the specified element
         * @param element Element to remove
         * @return true if the element was found and removed, false otherwise
         * @note This operation has O(n) time complexity.
         */
        bool erase(T element)
        {
            for (auto current = this->head; current; current = current->next)
            {
                if (current->value() == element)
                {
                    if (current->previous)
                        current->previous->next = current->next;
                    else
                        this->head = current->next;

                    if (current->next)
                        current->next->previous = current->previous;
                    else
                        this->tail = current->previous;

                    this->_count--;

                    return true;
                }
            }

            return false;
        }

    private:
        size_t _count = 0;             ///< Element counter
        std::shared_ptr<Node<T>> head; ///< First node pointer
        std::shared_ptr<Node<T>> tail; ///< Last node pointer
    };

} // namespace linked_list
