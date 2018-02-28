//
//  Level.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 `Level` is an abstract data structure that represents a certain game level,
 i.e., the initial placement of all bubbles.

 Internally, `Level` uses a 2D array to store all bubbles with their positions
 inside the grid. The elements of this 2D array are of type `BubbleType?`. In other
 words, if an item in this array is `nil`, it implies there is no bubble at this
 position. If it is not `nil`, that means there is a bubble with at this position,
 and the `BubbleType` of this bubble is the value of this item in the array.

 The grid (2D array) has different number of items on odd/even rows. Odd rows
 should have one fewer item than even rows.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class Level: Codable {
    /// The allowed number of rows in a `Level`.
    let numOfRows: Int = Settings.numOfRows
    /// The allowed number of bubbles on even rows.
    let evenCount: Int = Settings.cellPerRow
    /// The allowed number of bubbles on odd rows.
    let oddCount: Int = Settings.cellPerRow - 1

    /// Internal storage structure for all bubbles in a `Level`.
    private var bubbles: [[BubbleType?]]

    /// Creates a new level with default size.
    init() {
        bubbles = [[BubbleType?]](repeating: [BubbleType?](repeating: nil, count: evenCount),
                                  count: numOfRows)
    }

    /// Adds (or updates) a new bubble to the current `Level` at a certain
    /// position. If there already exists a bubble there, replace it. This
    /// method will simply do nothing if the given bubble is not at a legal
    /// position of the current `Level` or the existing bubble at the intended
    /// location is the same as the supplied bubble.
    /// - Parameters:
    ///    - toAdd: The type of the bubble being added.
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    func addOrUpdateBubble(_ toAdd: BubbleType, row: Int, column: Int) {
        guard getBubbleAt(row: row, column: column) != toAdd else {
            return
        }
        bubbles[row][column] = toAdd
    }

    /// Checks whether the current `Level` has a bubble located at the intended
    /// position.
    /// - Parameters:
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    /// - Returns: true if the provided location is valid and there is a bubble
    /// at the intended location; false otherwise.
    func hasBubbleAt(row: Int, column: Int) -> Bool {
        return isValidLocation(row: row, column: column)
            && bubbles[row][column] != nil
    }

    /// Gets the type of the bubble located at the specified location.
    /// - Parameters:
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    /// - Returns: the bubble type at that location if it exists; nil otherwise.
    func getBubbleAt(row: Int, column: Int) -> BubbleType? {
        guard isValidLocation(row: row, column: column) else {
            return nil
        }
        return bubbles[row][column]
    }

    /// Deletes a certain bubble from the current `Level` at a certain location;
    /// if there is no bubbble at that location, do nothing.
    /// - Parameters:
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    func deleteBubbleAt(row: Int, column: Int) {
        guard hasBubbleAt(row: row, column: column) else {
            return
        }
        bubbles[row][column] = nil
    }

    /// Checks whether a certain location is valid in a `Level`.
    /// - Parameters:
    ///    - row: The row number of the checked location (zero-based).
    ///    - column: The column number of the checked location (zero-based).
    private func isValidLocation(row: Int, column: Int) -> Bool {
        guard row >= 0 && row < numOfRows else {
            return false
        }

        if row % 2 == 0 {
            return column >= 0 && column < evenCount
        } else {
            return column >= 0 && column < oddCount
        }
    }
}
