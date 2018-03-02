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
        removeUnattachedBubbles()
    }

    func onCollide(lhs: PhysicsBody, rhs: PhysicsBody?) {
        if let bubble1 = lhs as? BubbleObject, let bubble2 = rhs as? BubbleObject? {
            handleCollsion(lhs: bubble1, rhs: bubble2)
        }
    }

    /// Handles the collsion between two `BubbleObject`s.
    private func handleCollsion(lhs: BubbleObject, rhs: BubbleObject?) {
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
        addAttachment(object: lhs)
        removeConnectedBubbles(from: lhs)
        removeUnattachedBubbles()
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

    /// Attaches the bubble with the nearby bubbles (because it has snapped to a
    /// certain cell).
    private func addAttachment(object: BubbleObject) {
        for item in engine.physicsObjects {
            if object.canAttachWith(object: item) {
                object.attachTo(item)
                item.attachTo(object)
            }
        }
    }

    /// Removes the connected bubbles either because they are of the same color or
    /// some special effects are triggered.
    /// - Parameter object: The `BubbleObject` to start from.
    private func removeConnectedBubbles(from object: BubbleObject) {
        // Checks whether there are any neighbors of special types.
        var toRemove = object.getSpecialNeighbors()
        // Special bubbles should always be triggered.
        let shouldRemove = !toRemove.isEmpty

        // Checks the same color bubbles and chaining effect.
        toRemove = checkSameTypeBubbles(startWith: toRemove, from: object)
        // Removes them either the number of bubbles achieve threshold or there exists
        // special bubbles around.
        if toRemove.count >= Settings.sameColorThreshold || shouldRemove {
            engine.deregisterPhysicsObject(contentsOf: toRemove)
        }
    }

    /// Gets the connected bubbles (with the same type) starting from this bubble and chaining
    /// effects due to power-up bubbles. The result includes this bubble itself.
    /// - Parameters:
    ///    - startWith: Some `BubbleObject`s that have been included due to special effects.
    ///    - object: The `BubbleObject` to start from.
    /// - Returns: An array of attached `BubbleObject`s of the same color.
    private func checkSameTypeBubbles(startWith: [BubbleObject], from object: BubbleObject) -> [BubbleObject] {
        var result: [BubbleObject] = []
        var toVisit = Stack<BubbleObject>()
        toVisit.push(object)
        toVisit.push(contentOf: startWith)

        // Marks all of them as unvisited.
        for item in engine.physicsObjects {
            if let bubble = item as? BubbleObject {
                bubble.visited = false
            }
        }
        // Starts a DFS to find all attached objects with the same color.
        while let next = toVisit.pop() {
            if !next.visited {
                result.append(next)
                next.visited = true
            }
            // Checks for the special effects.
            var bubbles: [BubbleObject] = []
            if next.type == .star {
                bubbles.append(contentsOf: getAllSameTypeBubbles(of: object.type))
            }
            if next.type == .lightning {
                bubbles.append(contentsOf: getSameRowBubbles(of: next))
            }
            if next.type == .bomb {
                bubbles.append(contentsOf: next.getNeighbors())
            }
            for bubble in bubbles {
                if !bubble.visited {
                    // Only allows "direct" chaining effect.
                    result.append(bubble)
                    bubble.visited = true
                }
            }
            // Checks for same-color connected bubble.
            for neighbor in next.getSameColorNeighbors() {
                if !neighbor.visited {
                    toVisit.push(neighbor)
                }
            }
        }

        return result
    }

    /// Finds all the bubbles of a certain type currently.
    /// - Parameter type: the type to find.
    /// - Returns: An array of bubbles of that type.
    private func getAllSameTypeBubbles(of type: BubbleType) -> [BubbleObject] {
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
    private func getSameRowBubbles(of object: BubbleObject) -> [BubbleObject] {
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

    /// Finds and removes the unattached bubbles. A bubble is defined as "unattached"
    /// if it is not connected to the top wall or any other attached bubbles.
    private func removeUnattachedBubbles() {
        updateAttachToTop()
        // Removes those "unattached" ones.
        for item in engine.physicsObjects {
            guard let bubble = item as? BubbleObject else {
                continue
            }
            if !bubble.isAttachedToTop {
                // A falling bubble cannot collide with others.
                bubble.isCollidable = false
                bubble.acceleration = CGVector(dx: 0, dy: Settings.gravityConstant)
            }
        }
    }

    /// Updates the status of all bubbles regarding whether they are attached to the
    /// top wall, either directly or indirectly.
    private func updateAttachToTop() {
        var toCheck = Stack<BubbleObject>()

        // Gets those who can directly touch the top wall first.
        for item in engine.physicsObjects {
            guard let bubble = item as? BubbleObject else {
                continue
            }
            if bubble.canTouchTopWall {
                bubble.isAttachedToTop = true
                toCheck.push(bubble)
            } else {
                bubble.isAttachedToTop = false
            }
            bubble.visited = false
        }

        // Starts a DFS to update the status of all bubbles.
        while let next = toCheck.pop() {
            if next.visited {
                continue
            }

            next.visited = true
            for neighbor in next.getNeighbors() where !neighbor.visited {
                neighbor.isAttachedToTop = true
                toCheck.push(neighbor)
            }
        }
    }
}
