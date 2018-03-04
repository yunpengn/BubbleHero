//
//  FixedQueue.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 A generic `FixedQueue` type whose elements are first-in, first-out (FIFO).
 Different from normal queues, a fixed queue always maintain a fixed number
 of elements inside. In other words, whenever an element is dequeued, a new
 element must be enqueued at the same time.

 Array is used as the internal data structure, which is sufficient for the
 purpose of this program. The time complexity for dequeue operation is not
 optimal.

 - Author: Niu Yunpeng @ CS3217
 - Date: Jan 2018
 */
struct FixedQueue<T> {
    /// An array used as the internal structure for data storage.
    private var internalArray: [T] = []
    /// The fixed size of this queue.
    let size: Int

    /// Creates a new fixed queue with the initial set of items inside.
    /// - Parameter content: The initial content of this fixed queue, whose
    /// size will decide the size of this fixed queue.
    init(with content: [T]) {
        self.size = content.count
        internalArray = content
    }

    /// Removes an element from the head of the queue and return it. To maintain
    /// the fixed size of the queue, a new item has to be enqueued simultaneously.
    /// - Parameter newItem: The new item to be enqueued.
    /// - Returns: item at the head of the queue.
    mutating func pop(byAdd newItem: T) -> T {
        internalArray.append(newItem)
        return internalArray.removeFirst()
    }

    /// Exchanges the two items.
    /// - Parameters:
    ///    - lhs: The index of the 1st item.
    ///    - rhs: The index of the 2nd item.
    mutating func exchangeItems(lhs: Int, rhs: Int) {
        guard isValidIndex(lhs), isValidIndex(rhs) else {
            return
        }
        internalArray.swapAt(lhs, rhs)
    }

    /// Gets the value of the item at a certain index, which must be within the size
    /// of the fixed queue.
    /// - Parameter index: The intended index.
    /// - Returns: The item if the index is valid; nil otherwise.
    func getItem(at index: Int) -> T? {
        guard isValidIndex(index) else {
            return nil
        }
        return internalArray[index]
    }

    /// Returns an array of the elements in their respective dequeue order, i.e.
    /// first element in the array is the first element to be dequeued.
    /// - Returns: array of elements in their respective dequeue order
    func toArray() -> [T] {
        return internalArray
    }

    /// Checks whether a given index is valid.
    /// - Parameter index: The index being checked.
    /// - Returns: true if it is valid; false otherwise.
    private func isValidIndex(_ index: Int) -> Bool {
        return index >= 0 && index < size
    }
}
