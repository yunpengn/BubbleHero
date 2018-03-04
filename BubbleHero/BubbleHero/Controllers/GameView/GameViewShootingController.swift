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
    let animator: GameViewAnimationController
    /// The delegate for launch controller.
    weak var launchControllerDelegate: GameViewLaunchControllerDelegate?
    /// The delegate for score controller.
    let scoreControllerDelegate: GameViewScoreControllerDelegate

    /// Creates a shooting controller with its associated physics engine.
    /// - Parameter
    ///    - engine: The physics engine attached.
    ///    - view: The game area.
    ///    - score: The delegate for score controller.
    init(engine: PhysicsEngine2D, view: UIView, score: GameViewScoreControllerDelegate) {
        self.engine = engine
        self.scoreControllerDelegate = score
        fallingController = GameViewFallingController(engine: engine, score: score)
        fallingController.removeUnattachedBubbles()
        animator = GameViewAnimationController(view: view)
    }

    func onCollide(lhs: PhysicsBody, rhs: PhysicsBody?) {
        if let bubble1 = lhs as? BubbleObject, let bubble2 = rhs as? BubbleObject? {
            launchControllerDelegate?.prepareForNextLaunch()
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
                scoreControllerDelegate.addScore(for: bubble.object, by: .fromEffect(bubble.effect))
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
            guard !next.visited else {
                continue
            }

            // Adds the current bubble to result
            next.visited = true
            result.append((next, .fromBubbleType(next.type)))

            // Checks for special effects.
            let specialEffect = getSpecialAffectedBubbles(by: next)
            specialEffect.forEach { bubble in
                bubble.visited = true
                result.append((bubble, .fromBubbleType(bubble.type)))
            }

            // Checks for same-color connected bubble.
            for neighbor in next.getSameColorNeighbors() where !neighbor.visited {
                toVisit.push(neighbor)
            }
        }

        return result
    }

    /// Finds all the bubbles affected by a certain special effect.
    /// - Parameter bubble: The bubble in concer.
    /// - Returns: an array of bubbles affected by the special effect; an empty array
    /// if there is no special effect.
    func getSpecialAffectedBubbles(by bubble: BubbleObject) -> [BubbleObject] {
        switch bubble.type {
        case .star:
            return getAllSameTypeBubbles(of: bubble.type)
        case .lightning:
            return getSameRowBubbles(of: bubble)
        case .bomb:
            return bubble.getNeighbors()
        default:
            return []
        }
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
    case lightning

    /// Converts from `BubbleType` to `RemoveAnimation`.
    /// - Parameter type: The `BubbleType`.
    /// - Returns: The `RemoveAnimation` converted.
    static func fromBubbleType(_ type: BubbleType) -> RemoveAnimation {
        switch type {
        case .lightning:
            return .lightning
        case .bomb:
            return .bomb
        case .star:
            return .star
        default:
            return .none
        }
    }
}
