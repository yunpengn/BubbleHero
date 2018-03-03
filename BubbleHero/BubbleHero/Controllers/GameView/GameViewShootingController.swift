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
    /// The controller for animation.
    let animator = GameViewAnimationController()

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
        let specials = object.getSpecialNeighbors()
        // Special bubbles should always be triggered.
        let shouldRemove = !specials.isEmpty

        // Checks the same color bubbles and chaining effect.
        let toRemove = checkSameTypeBubbles(startWith: specials, from: object)
        // Removes them either the number of bubbles achieve threshold or there exists
        // special bubbles around.
        if toRemove.count >= Settings.sameColorThreshold || shouldRemove {
            for bubble in toRemove {
                animator.animate(object: bubble.object, effect: bubble.effect)
                engine.deregisterPhysicsObject(bubble.object)
            }
        }
    }

    /// Gets the connected bubbles (with the same type) starting from this bubble and chaining
    /// effects due to power-up bubbles. The result includes this bubble itself.
    /// - Parameters:
    ///    - startWith: Some `BubbleObject`s that have been included due to special effects.
    ///    - object: The `BubbleObject` to start from.
    /// - Returns: An array of `BubbleObjects` to remove and their reasons of being removed.
    private func checkSameTypeBubbles(startWith: [BubbleObject], from object: BubbleObject)
        -> [(object: BubbleObject, effect: RemoveAnimation)] {
        var result: [(object: BubbleObject, effect: RemoveAnimation)] = []
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
            // Checks for the special effects (and only allows 2nd-order chaing effect).
            if next.type == .star {
                for bubble in getAllSameTypeBubbles(of: object.type) {
                    bubble.visited = true
                    result.append((bubble, .star))
                }
                next.visited = true
                result.append((next, .star))
            } else if next.type == .lightning {
                animator.addLightningLine(at: next.view.frame.midX)
                for bubble in getSameRowBubbles(of: next) {
                    bubble.visited = true
                    result.append((bubble, .none))
                }
                next.visited = true
                result.append((next, .none))
            } else if next.type == .bomb {
                for bubble in next.getNeighbors() {
                    bubble.visited = true
                    result.append((bubble, .bomb))
                }
                next.visited = true
                result.append((next, .bomb))
            } else if !next.visited {
                result.append((next, .none))
                next.visited = true
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

/**
 An enum indicating the animation to use when removing a bubble.
 */
enum RemoveAnimation {
    case none
    case bomb
    case star
}
