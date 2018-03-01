//
//  GameViewShootingController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for interactions between bubbles in game view, which assists `GameViewController`
 for functionalities related to bubble collision.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewShootingController: EngineControllerDelegate {
    /// The physics engine associated with this controller.
    private let engine: PhysicsEngine2D

    /// Creates a shooting controller with its associated physics engine.
    /// - Parameter engine: The physics engine attached.
    init(engine: PhysicsEngine2D) {
        self.engine = engine
    }

    func onCollide(lhs: PhysicsBody, rhs: PhysicsBody?) {
        lhs.stop()
        rhs?.stop()
        if let bubble1 = lhs as? BubbleObject, let bubble2 = rhs as? BubbleObject? {
            handleCollsion(lhs: bubble1, rhs: bubble2)
        }
    }

    /// Handles the collsion between two `BubbleObject`s.
    private func handleCollsion(lhs: BubbleObject, rhs: BubbleObject?) {
        if lhs.isSnapping {
            snapToNearbyCell(lhs)
            addAttachment(object: lhs)
        } else {
            adjustPosition(to: rhs)
        }
        let sameColor = getSameColorConnectedBubbles(from: lhs)
        if sameColor.count >= Settings.sameColorThreshold {
            engine.deregisterPhysicsObject(contentsOf: sameColor)
        }
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

    /// Attaches the bubble with the nearby bubbles (because it has snapped to a
    /// certain cell).
    private func addAttachment(object: BubbleObject) {
        for item in engine.physicsObjects {
            if object.canAttachWith(object: item) {
                object.attachTo(item)
                item.attachTo(object)
            }
        }
        print(object.attachedWith.count)
    }

    /// Adjusts the position a little bit so that a non-snapping bubble can barely
    /// touch its attached bubble.
    private func adjustPosition(to object: PhysicsBody?) {

    }

    /// Gets the connected bubbles (with the same color) starting from this bubble.
    /// The result includes this bubble itself.
    /// - Parameter object: The `BubbleObject` to start from.
    /// - Returns: An array of attached `BubbleObject`s of the same color.
    private func getSameColorConnectedBubbles(from object: BubbleObject) -> [BubbleObject] {
        var result: [BubbleObject] = []
        var toVisit = Stack<BubbleObject>()
        toVisit.push(object)

        // Starts a DFS to find all attached objects with the same color.
        while let next = toVisit.pop() {
            if !result.contains { $0 === next } {
                result.append(next)
            }

            for neighbor in next.getSameColorNeighbors() {
                if !result.contains { $0 === neighbor } {
                    toVisit.push(neighbor)
                }
            }
        }

        return result
    }
}
