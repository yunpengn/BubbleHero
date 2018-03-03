//
//  GameViewSnapController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for interactions between bubbles in game view, which assists the logic about
 snapping & non-snapping bubbles.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewSnapController {
    /// Decides the snapping behaviors between two objects.
    /// - Parameters:
    ///    - lhs: The first object.
    ///    - rhs: The second object.
    func snap(lhs: BubbleObject, rhs: BubbleObject?) {
        if let other = rhs, !other.isSnapping {
            lhs.isSnapping = false
            if let view = lhs.view as? BubbleView {
                view.addBorder()
            }
        }
        // Moves the bubble according to whether it is snapping bubble.
        if lhs.isSnapping {
            snapToNearbyCell(lhs)
        } else {
            adjustPosition(from: lhs, to: rhs)
        }
        lhs.stop()
        rhs?.stop()
    }
    
    /// Finds the position of the nearby cell and moves to it.
    /// - Parameter object: The `BubbleObject` to move.
    private func snapToNearbyCell(_ object: BubbleObject) {
        let minY = max(object.center.y - object.radius, 0)
        let row = round((minY) / FillableBubbleCell.height)
        let newY = row * FillableBubbleCell.height + object.radius

        let leftOffset = (Int(row) % 2 == 0) ? 0 : FillableBubbleCell.leftOffset
        let minX = max(object.center.x - object.radius, leftOffset)
        let column = round((minX - leftOffset) / FillableBubbleCell.diameter)
        let newX = column * FillableBubbleCell.diameter + leftOffset + object.radius

        object.move(to: CGPoint(x: newX, y: newY))
    }

    /// Adjusts the position a little bit so that a non-snapping bubble can barely
    /// touch its attached bubble.
    private func adjustPosition(from: BubbleObject, to: BubbleObject?) {
        guard let other = to else {
            from.center.y = from.radius
            return
        }
        // Adjusts it until they can merely attach to each other.
        let dx = -from.velocity.dx * Settings.adjustmentUnit
        let dy = -from.velocity.dy * Settings.adjustmentUnit
        while from.canAttachWith(object: other) {
            from.move(by: CGVector(dx: dx, dy: dy))
        }
        from.move(by: CGVector(dx: -dx, dy: -dy))
    }
}
