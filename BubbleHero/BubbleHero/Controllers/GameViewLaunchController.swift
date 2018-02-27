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
    private let cannon: UIView
    /// The current angle for the cannon.
    private var cannonAngle = CGFloat(CGFloat.pi / 2)

    init(cannon: UIView) {
        self.cannon = cannon
        cannon.layer.anchorPoint = Settings.launchCannonAnchorPoint
        cannon.transform = cannon.transform.translatedBy(x: 0, y: Settings.launchCannonTransformY)
    }

    /// Rotates the cannon body so that it faces a certain point.
    /// - Parameter point: The point that the cannon is supposed to face.
    func rotateCannon(to point: CGPoint) {
        let newAngle = getShootAngle(by: point)
        guard isAcceptedAngle(newAngle) else {
            return
        }
        cannon.transform = cannon.transform.rotated(by: newAngle - cannonAngle)
        cannonAngle = newAngle
    }

    /// Launches a bubble in the direction of a point.
    /// - Parameter point: The point that the direction of the shooted bubble
    /// should be in.
    func launchBubble(to point: CGPoint) {
        let angle = getShootAngle(by: point)
        guard isAcceptedAngle(angle) else {
            return
        }

    }

    /// Given a point at which the user touches, computes the initial angle of the
    /// bubble being shooted.
    ///
    /// The angle computed will increment when rotating anti-clockwise in the range
    /// of [0, PI]. Notice that we only allow the user to launch bubbles upwards.
    /// - Parameter point: The point at which the user touches.
    /// - Returns: The initial angle of the launched angle.
    private func getShootAngle(by point: CGPoint) -> CGFloat {
        let deltaX = cannon.center.x - point.x
        let deltaY = cannon.center.y - point.y
        let newDeltaY = deltaY > 0 ? deltaY : 0
        return atan2(newDeltaY, deltaX)
    }

    /// Checks whether the given angle is accepted, i.e., the angle must be upwards.
    private func isAcceptedAngle(_ angle: CGFloat) -> Bool {
        return angle > Settings.launchAngleLowerLimit
            && angle < Settings.launchAngleUpperLimit
    }
}
