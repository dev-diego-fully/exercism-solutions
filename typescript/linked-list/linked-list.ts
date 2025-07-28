/**
 * Represents a doubly linked list data structure.
 *
 * This class provides methods to manipulate a list of elements,
 * allowing efficient addition and removal from both ends, as well as
 * deletion of specific elements. Each element maintains links to
 * the previous and next elements in the sequence.
 *
 * @template T The type of elements stored in the linked list.
 */
export class LinkedList<T> {
  /**
   * @var head The first node in the linked list. Is `null` if the list is empty.
   */
  private head: Link<T>;
  /**
   * @var tail The last node in the linked list. Is `null` if the list is empty.
   */
  private tail: Link<T>;
  /**
   * @var length The current number of elements in the linked list.
   */
  private length: number;

  /**
   * Initializes a new empty LinkedList.
   */
  constructor() {
    this.head = null;
    this.tail = null;
    this.length = 0;
  }

  /**
   * Adds a new element to the end of the linked list.
   *
   * If the list is empty, the new element becomes both the head and the tail.
   *
   * @param element The element to add to the list.
   */
  public push(element: T) {
    if (this.tail === null) {
      this.initWith(element);
    } else {
      this.tail.next = new Node(element, this.tail, null);
      this.tail = this.tail.next;
    }
    this.length++;
  }

  /**
   * Removes and returns the element from the end of the linked list.
   *
   * @returns The element removed from the end, or `undefined` if the list was empty.
   */
  public pop(): T | undefined {
    if (this.tail === null) {
      return undefined;
    }

    const popped = this.tail.element;
    this.length--;

    if (this.tail.prev === null) {
      this.head = null;
      this.tail = null;
    } else {
      this.tail = this.tail.prev;
      this.tail.next = null;
    }

    return popped;
  }

  /**
   * Removes and returns the element from the beginning of the linked list.
   *
   * @returns The element removed from the beginning, or `undefined` if the list was empty.
   */
  public shift(): T | undefined {
    if (this.head === null) {
      return undefined;
    }

    const shiffted = this.head.element;
    this.length--;

    if (this.head.next === null) {
      this.head = null;
      this.tail = null;
    } else {
      this.head = this.head.next;
      this.head.prev = null;
    }

    return shiffted;
  }

  /**
   * Adds a new element to the beginning of the linked list.
   *
   * If the list is empty, the new element becomes both the head and the tail.
   *
   * @param element The element to add to the list.
   */
  public unshift(element: T) {
    if (this.head === null) {
      this.initWith(element);
    } else {
      this.head.prev = new Node(element, null, this.head);
      this.head = this.head.prev;
    }
    this.length++;
  }

  /**
   * Deletes the first occurrence of a specific element from the linked list.
   *
   * If the element is found, it's removed and the list length is decremented.
   * If the element is not found, the list remains unchanged.
   *
   * @param element The element to delete from the list.
   */
  public delete(element: T) {
    for (let current = this.head; current !== null; current = current.next) {
      if (current.element === element) {
        if (current.prev === null) {
          this.head = current.next;

        } else {
          current.prev.next = current.next;
        }

        if (current.next === null) {
          this.tail = current.prev;

        } else {
          current.next.prev = current.prev;
        }

        this.length--;
        return;
      }
    }
  }

  /**
   * Returns the current number of elements in the linked list.
   *
   * @returns The count of elements.
   */
  public count(): number {
    return this.length;
  }

  /**
   * Initializes the list with a single element when it is empty.
   * Sets both head and tail to a new node containing the element.
   *
   * @param element The first element to add to the newly initialized list.
   */
  private initWith(element: T) {
    this.head = new Node(element);
    this.tail = this.head;
  }
}

/**
 * Represents a single node within the LinkedList.
 *
 * Each node holds an element and references to the next and previous nodes in the list.
 *
 * @template T The type of the element stored in the node.
 */
class Node<T> {
  /**
   * @var element The data stored in this node.
   */
  public element: T;
  /**
   * @var next A reference to the next node in the list, or `null` if this is the last node.
   */
  public next: Link<T>;
  /**
   * @var prev A reference to the previous node in the list, or `null` if this is the first node.
   */
  public prev: Link<T>;

  /**
   * Creates a new Node instance.
   *
   * @param element The element to store in this node.
   * @param prev An optional reference to the previous node. Defaults to `null`.
   * @param next An optional reference to the next node. Defaults to `null`.
   */
  constructor(element: T, prev: Link<T> = null, next: Link<T> = null) {
    this.element = element;
    this.next = next;
    this.prev = prev;
  }
}

/**
 * Defines a type alias for a link in the LinkedList, which can be a Node or `null`.
 * This is used to indicate optional or absent connections between nodes.
 *
 * @template T The type of elements in the linked list node.
 */
type Link<T> = Node<T> | null;