#include "simple_linked_list.h"

namespace simple_linked_list {

std::size_t List::size() const { return this->current_size; }

void List::push(int entry) {
  Element *pushed = new Element(entry);

  if (this->current_size == 0) {
    this->head = pushed;
    this->tail = pushed;

  } else {
    this->tail->next = pushed;
    this->tail = pushed;
  }

  this->current_size++;
}

int List::pop() {
  if (this->current_size == 0) {
    throw std::length_error("List is empty. Can't remove.");
  }
  int value;
  if (this->current_size == 1) {
    value = this->head->data;
    delete this->head;
    this->head = nullptr;
    this->tail = nullptr;

  } else {
    Element *pre_popped = this->head;

    for (size_t i = 1; i < this->current_size - 1; i++) {
      pre_popped = pre_popped->next;
    }

    value = pre_popped->next->data;
    pre_popped->next = nullptr;
    this->tail = pre_popped;
  }

  this->current_size--;
  return value;
}

void List::reverse() {
  Element *prev{nullptr};
  Element *current = this->head;

  for (size_t i = 0; i < this->current_size; i++) {
    Element *next = current->next;
    current->next = prev;
    prev = current;
    current = next;
  }

  Element *aux = this->head;
  this->head = this->tail;
  this->tail = aux;
}

List::~List() {
  Element *current = head;

  while (current != tail) {
    Element *next = current->next;
    delete current;
    current = next;
  }
}

} // namespace simple_linked_list
