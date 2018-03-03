//
//  GameViewShootingController+Helpers.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Extension for `GameViewShootingController`, which contains some helper methods.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension GameViewShootingController {
    /// Finds all the bubbles of a certain type currently.
    /// - Parameter type: the type to find.
    /// - Returns: An array of bubbles of that type.
    func getAllSameTypeBubbles(of type: BubbleType) -> [BubbleObject] {
        var result: [BubbleObject] = []
        for item in engine.physicsObjects {
            guard let bubble = item as? BubbleObject else {
                continue
            }
            if bubble.type == type {
                result.append(bubble)
            }
        }
        return result
    }

    /// Finds all bubbles in the same role as a certain bubble.
    /// - Parameter object: The `BubbleObject` in concern.
    /// - Returns: An array of bubbles in the same role.
    func getSameRowBubbles(of object: BubbleObject) -> [BubbleObject] {
        var result: [BubbleObject] = []
        for item in engine.physicsObjects {
            guard let bubble = item as? BubbleObject else {
                continue
            }
            if object.isInSameRow(as: bubble) {
                result.append(bubble)
            }
        }
        return result
    }
}
