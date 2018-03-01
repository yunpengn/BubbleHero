//
//  RandomDataHelpers.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Defines some utility methods to help create random data for a level..

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class RandomDataHelpers {
    /// Loads a sample level for convenience.
    static func loadSampleLevel() -> Level {
        let level = Level()

        for i in 0..<12 {
            addRandomTypeBubble(to: level, row: 0, column: i)
            addRandomTypeBubble(to: level, row: 2, column: i)
            if i != 5 && i != 8 {
                addRandomTypeBubble(to: level, row: 4, column: i)
            }
            addRandomTypeBubble(to: level, row: 6, column: i)

        }
        for i in 0..<11 {
            addRandomTypeBubble(to: level, row: 1, column: i)
            addRandomTypeBubble(to: level, row: 3, column: i)
            if i != 3 && i != 10 {
                addRandomTypeBubble(to: level, row: 5, column: i)
            }
            addRandomTypeBubble(to: level, row: 7, column: i)
        }

        return level
    }

    /// Adds a bubble of random `BubbleType` at the given location.
    /// - Parameters:
    ///    - level: The level that the generated bubble will be added to.
    ///    - row: The row number of the new bubble.
    ///    - column: The column number of the new bubble.
    private static func addRandomTypeBubble(to level: Level, row: Int, column: Int) {
        level.addOrUpdateBubble(BubbleType.getRandomBasicType(), row: row, column: column)
    }
}
