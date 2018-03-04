//
//  Stack.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 A generic `Stack` class whose elements are last-in, first-out (LIFO).

 Array is used as the internal data structure, which is sufficient for the
 purpose of this program.

 - Author: Niu Yunpeng @ CS3217
 - Date: Jan 2018
 */
struct Stack<T> {
    /// An array used as the internal structure for data storage.
    private var internalArray: [T] = []

    /// Adds an element to the top of the stack.
    /// - Parameter item: The element to be added to the stack
    mutating func push(_ item: T) {
        internalArray.append(item)
    }

    /// Adds an array of elements on the top of the stack.
    /// - Parameter items: The elements to be added to the stack.
    mutating func push(contentOf items: [T]) {
        internalArray.append(contentsOf: items)
    }

    /// Removes the element at the top of the stack and return it.
    /// - Returns: the element at the top of the stack if the stack is not
    /// empty; otherwise, nil.
    mutating func pop() -> T? {
        return internalArray.popLast()
    }

    /// Returns, but does not remove, the element at the top of the stack.
    /// - Returns: element at the top of the stack if the stack is not
    /// empty; otherwise, nil
    func peek() -> T? {
        return internalArray.last
    }

    /// The number of elements currently in the stack.
    var count: Int {
        return internalArray.count
    }

    /// Whether the stack is empty.
    var isEmpty: Bool {
        return internalArray.isEmpty
    }

    /// Removes all elements in the stack.
    mutating func removeAll() {
        internalArray.removeAll()
    }

    /// Returns an array of the elements in their respective pop order, i.e.
    /// first element in the array is the first element to be popped.
    /// - Returns: array of elements in their respective pop order
    func toArray() -> [T] {
        return internalArray.reversed()
    }
}
