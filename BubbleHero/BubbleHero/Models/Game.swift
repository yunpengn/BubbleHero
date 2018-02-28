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
    
    init(from level: Level) {
        for row in 0..<level.numOfRows {
            var current: [BubbleObject?] = []
            let size = (row % 2 == 0) ? level.evenCount : level.oddCount
            for column in 0..<size {
                guard let type = level.getBubbleAt(row: row, column: column) else {
                    current.append(nil)
                    continue
                }
                current.append(Helpers.toBubbleObject(type: type, row: row, column: column))
            }
            bubbles.append(current)
        }
    }
}
