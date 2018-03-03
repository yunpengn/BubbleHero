//
//  GameViewShootingController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit
import GameEngine

/**
 Controller for interactions between bubbles in game view, which assists `GameViewController`
 for functionalities related to bubble collision.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewShootingController: EngineControllerDelegate {
    /// The physics engine associated with this controller.
    let engine: PhysicsEngine2D
    /// The controller for logics related to snapping/non-snapping bubbles.
    let snapController = GameViewSnapController()
    /// The controller for falling bubbles.
    let fallingController: GameViewFallingController

    /// Creates a shooting controller with its associated physics engine.
    /// - Parameter engine: The physics engine attached.
    init(engine: PhysicsEngine2D) {
        self.engine = engine
        fallingController = GameViewFallingController(engine: engine)
        fallingController.removeUnattachedBubbles()
    }

    func onCollide(lhs: PhysicsBody, rhs: PhysicsBody?) {
        if let bubble1 = lhs as? BubbleObject, let bubble2 = rhs as? BubbleObject? {
            snapController.snap(lhs: bubble1, rhs: bubble2)
            addAttachment(object: bubble1)
            removeConnectedBubbles(from: bubble1)
            fallingController.removeUnattachedBubbles()
        }
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
}
