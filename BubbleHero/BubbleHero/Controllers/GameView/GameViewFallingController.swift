//
//  GameViewFallingController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import GameEngine

/**
 Controller for the falling bubbles in the game view.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewFallingController {
    /// The physics engine associated with the controller.
    private let engine: PhysicsEngine2D
    /// The delegate for score controller.
    let scoreControllerDelegate: GameViewScoreControllerDelegate

    /// Creates a new falling controller.
    /// - Parameters:
    ///    - engine: The game engine associated.
    ///    - score: The score controller.
    init(engine: PhysicsEngine2D, score: GameViewScoreControllerDelegate) {
        self.engine = engine
        self.scoreControllerDelegate = score
    }

    /// Finds and removes the unattached bubbles. A bubble is defined as "unattached"
    /// if it is not connected to the top wall or any other attached bubbles.
    func removeUnattachedBubbles() {
        updateAttachToTop()
        // Removes those "unattached" ones.
        for item in engine.physicsObjects {
            guard let bubble = item as? BubbleObject else {
                continue
            }
            if !bubble.isAttachedToTop {
                scoreControllerDelegate.addScore(for: bubble, by: .falling)
                // A falling bubble cannot collide with others.
                bubble.isCollidable = false
                bubble.isAttractable = false
                // Magnetic bubbles should lose magnetism now.
                if let magnetism = bubble as? MagneticBubbleObject {
                    magnetism.canAttract = false
                }
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
