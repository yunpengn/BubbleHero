//
//  GameViewLaunchController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the bubble launcher in game view, which assists `GameViewController`
 for functionalities related to bubble launch and cannon update.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewLaunchController {
    /// The view for cannon which can visually shoot a bubble.
    private let cannon: CannonView
    /// The view to show the next bubble to be launched.
    private let nextBubble: BubbleView
    /// The view to show the next second bubble to be launched.
    private let nextSecondBubble: BubbleView
    /// The current angle for the cannon.
    private var cannonAngle = CGFloat(CGFloat.pi / 2)
    /// The source for bubbles to launch.
    private var source = BubbleSource(next: Settings.numOfPreviewBubbles)
    /// The engine to take over the control for bubbles shot.
    var engine: PhysicsEngine2D?

    init(cannon: CannonView, nextBubble: BubbleView, nextSecondBubble: BubbleView) {
        self.cannon = cannon
        self.nextBubble = nextBubble
        self.nextSecondBubble = nextSecondBubble
        updateView()
    }

    /// Rotates the cannon body so that it faces a certain point.
    /// - Parameter point: The point that the cannon is supposed to face.
    func rotateCannon(to point: CGPoint) {
        let newAngle = getShootAngle(by: point)
        cannon.transform = cannon.transform.rotated(by: newAngle - cannonAngle)
        cannonAngle = newAngle
    }

    /// Launches a bubble in the direction of a point.
    /// - Parameter point: The point that the direction of the shot bubble
    /// should be in.
    func launchBubble(to point: CGPoint) {
        let angle = getShootAngle(by: point)
        shootBubble(type: BubbleType.blue, angle: angle)
        cannon.startAnimating()
        updateView()
    }

    /// Shoots a certain `BubbleType` of bubble towards the specific angle.
    /// - Parameters:
    ///    - type: The type of the bubble to be shot.
    ///    - angle: The angle to shoot towards.
    private func shootBubble(type: BubbleType, angle: CGFloat) {
        let newBubble = source.pop()
        let bubbleObject = Helpers.toBubbleObject(type: newBubble.type,
                                                isSnapping: newBubble.isSnapping,
                                                center: getShootCenter(by: angle))
        bubbleObject.velocity = getShootVelocity(by: angle)
        engine?.registerPhysicsObject(bubbleObject)
    }

    /// Given a point at which the user touches, computes the initial angle of the
    /// bubble being shot.
    ///
    /// The angle computed will increment when rotating anti-clockwise in the range
    /// of [0, PI]. Notice that we only allow the user to launch bubbles upwards.
    /// - Parameter point: The point at which the user touches.
    /// - Returns: The initial angle of the launched angle.
    private func getShootAngle(by point: CGPoint) -> CGFloat {
        let deltaX = cannon.center.x - point.x
        let deltaY = cannon.center.y - point.y
        let newDeltaY = max(deltaY, Settings.launchVerticalLimit)
        return atan2(newDeltaY, deltaX)
    }

    /// Computes the initial velocity of the shot bubble according to the angle.
    /// - Parameter angle: The angle in which the bubble is shot.
    /// - Returns: A `CGVector` representing the speed of the shot bubble.
    private func getShootVelocity(by angle: CGFloat) -> CGVector {
        let dX = -Settings.shootSpeed * cos(angle)
        let dY = -Settings.shootSpeed * sin(angle)
        return CGVector(dx: dX, dy: dY)
    }

    /// Computes the center of the shot bubble to decide its initial position.
    /// - Parameter angle: The angle in which the bubble is shot.
    /// - Returns: A `CGPoint` representing the position of the shot bubble.
    private func getShootCenter(by angle: CGFloat) -> CGPoint {
        let diff = Settings.launchCannonTransformY
        let x = cannon.center.x + diff * cos(CGFloat.pi - angle)
        let y = cannon.center.y + diff * sin(CGFloat.pi - angle)
        return CGPoint(x: x, y: y)
    }

    /// Updates the status of the view elements after one bubble in shot.
    private func updateView() {
        guard let nextOne = source.getBubble(at: 0),
            let nextSecond = source.getBubble(at: 1) else {
                fatalError("Some internal settings are wrong.")
        }

        nextBubble.image = Helpers.toBubbleImage(of: nextOne.type)
        if !nextOne.isSnapping {
            nextBubble.addBorder()
        } else {
            nextBubble.removeBorder()
        }
        nextSecondBubble.image = Helpers.toBubbleImage(of: nextSecond.type)
        if !nextSecond.isSnapping {
            nextSecondBubble.addBorder()
        } else {
            nextSecondBubble.removeBorder()
        }
    }
}
