//
//  Game.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

class Game {
    /// Internal storage structure for all `BubbleObject`s.
    private var bubbles: [[BubbleObject?]] = []
    /// A list of `BubbleObject`s that the game starts with.
    var bubbleObjects: [BubbleObject] = []
    /// The allowed number of bubbles on even rows.
    private let evenCount: Int
    /// The allowed number of bubbles on odd rows.
    private let oddCount: Int

    /// Creates a `Game` object from a `Level` object.
    /// - Parameter level: The `Level` object to create from.
    init(from level: Level) {
        self.evenCount = level.evenCount
        self.oddCount = level.oddCount

        for row in 0..<level.numOfRows {
            var current: [BubbleObject?] = []
            let size = (row % 2 == 0) ? evenCount : oddCount
            for column in 0..<size {
                guard let type = level.getBubbleAt(row: row, column: column) else {
                    current.append(nil)
                    continue
                }
                current.append(Helpers.toBubbleObject(type: type, row: row, column: column))
            }
            bubbles.append(current)
        }

        for row in 0..<bubbles.count {
            let size = (row % 2 == 0) ? evenCount : oddCount
            for column in 0..<size {
                guard let object = bubbles[row][column] else {
                    continue
                }
                for neighbor in getNeighborsOf(row: row, column: column) {
                    object.attachTo(neighbor)
                }
                bubbleObjects.append(object)
            }
        }
    }

    /// Gets the neighbors of a certain location, i.e., the items at the nearby
    /// indices which are not `nil`.
    ///
    /// Notice: the nearby indices here are defined as the cellular network. Thus,
    /// there are at most 6 neighbors.
    /// - Parameters:
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    /// - Returns: An array of neighbors if there exists; empty array otherwise.
    private func getNeighborsOf(row: Int, column: Int) -> [BubbleObject] {
        var neighbors: [BubbleObject?] = []

        let nearRowOffset = (row % 2 == 0) ? -1 : 1
        neighbors.append(bubbles[row][column - 1])
        neighbors.append(bubbles[row][column + 1])
        neighbors.append(bubbles[row - 1][column])
        neighbors.append(bubbles[row - 1][column + nearRowOffset])
        neighbors.append(bubbles[row + 1][column])
        neighbors.append(bubbles[row + 1][column + nearRowOffset])

        return neighbors.flatMap { $0 }
    }
}
