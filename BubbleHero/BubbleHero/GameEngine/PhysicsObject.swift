//
//  PhysicsObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Each object registered in the `PhysicsEngine` must be a `PhysicsBody`. A
 `PhysicsObject` is a class which conforms to the `PhysicsBody` protocol.
 Thus, it possesses some physics properties, like position, velocity &
 acceleration, etc.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class PhysicsObject: PhysicsBody {
    let view: UIView
    var acceleration = CGVector.zero
    var velocity = CGVector.zero
    var center: CGPoint
    let radius: CGFloat
    let isCollidable: Bool

    // An array of objects that it is attached to.
    var attachedWith: [PhysicsBody] = []

    /// Creates a `PhysicsObject` by associating it with a `UIView` object.
    /// - Parameters:
    ///    - center: The coordinate for the center of the `PhysicsObject`.
    ///    - radius: The radius of this `PhysicsObject`.
    ///    - isCollidable: Indicates whether this `PhysicsObject` is collidable.
    ///    - view: The `UIView` object associated with.
    init(center: CGPoint, radius: CGFloat, isCollidable: Bool, view: UIView) {
        self.center = center
        self.radius = radius
        self.isCollidable = isCollidable
        self.view = view
    }

    /// Creates a `PhysicsObject` with the default setting that its visual center is its
    /// actual center.
    convenience init(isCollidable: Bool, view: UIView) {
        let center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        let radius = view.frame.width / 2
        self.init(center: center, radius: radius, isCollidable: isCollidable, view: view)
    }

    /// Creates a `PhysicsObject` with the default setting that it is a rigid body.
    convenience init(view: UIView) {
        self.init(isCollidable: true, view: view)
    }

    func move() {
        move(by: velocity)
        velocity = CGVector(dx: velocity.dx + acceleration.dx, dy: velocity.dy + acceleration.dy)
    }

    func move(by delta: CGVector) {
        center = CGPoint(x: center.x + velocity.dx, y: center.y + velocity.dy)
    }

    func move(to point: CGPoint) {
        center = point
    }

    func stop() {
        velocity = CGVector.zero
        acceleration = CGVector.zero
    }

    func brake() {
        velocity = CGVector.zero
    }

    func didCollideWith(_ object: PhysicsBody) -> Bool {
        guard isCollidable && object.isCollidable else {
            return false
        }
        let sqrX = (center.x - object.center.x) * (center.x - object.center.x)
        let sqrY = (center.y - object.center.y) * (center.y - object.center.y)
        let sqrRadius = (radius + object.radius) * (radius + object.radius)
        return sqrX + sqrY <= sqrRadius * EngineSettings.collisionThreshold
    }

    func attachTo(_ object: PhysicsBody) {
        guard object !== self && !isAttachedTo(object) else {
            return
        }
        attachedWith.append(object)
    }

    func isAttachedTo(_ object: PhysicsBody) -> Bool {
        return attachedWith.contains { $0 === object }
    }

    func canAttachWith(object: PhysicsBody) -> Bool {
        let sqrX = (center.x - object.center.x) * (center.x - object.center.x)
        let sqrY = (center.y - object.center.y) * (center.y - object.center.y)
        let sqrRadius = (radius + object.radius) * (radius + object.radius)
        return sqrX + sqrY <= sqrRadius * EngineSettings.attachmentThreshold
    }

    func reflectX() {
        velocity = CGVector(dx: -velocity.dx, dy: velocity.dy)
    }

    func reflectY() {
        velocity = CGVector(dx: velocity.dx, dy: -velocity.dy)
    }

    var isStatic: Bool {
        return velocity == CGVector.zero && acceleration == CGVector.zero
    }
}
