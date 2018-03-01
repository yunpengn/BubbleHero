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
    let isRigidBody: Bool

    // An array of objects that it is attached to.
    private var attachedWith: [PhysicsBody] = []

    /// Creates a `PhysicsObject` by associating it with a `UIView` object.
    /// - Parameters:
    ///    - center: The coordinate for the center of the `PhysicsObject`.
    ///    - radius: The radius of this `PhysicsObject`.
    ///    - isRigidBody: Indicates whether this `PhysicsObject` is a rigid body.
    ///    - view: The `UIView` object associated with.
    init(center: CGPoint, radius: CGFloat, isRigidBody: Bool, view: UIView) {
        self.center = center
        self.radius = radius
        self.isRigidBody = isRigidBody
        self.view = view
    }

    /// Creates a `PhysicsObject` with the default setting that its visual center is its
    /// actual center.
    convenience init(isRigidBody: Bool, view: UIView) {
        let center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        let radius = view.frame.width / 2
        self.init(center: center, radius: radius, isRigidBody: isRigidBody, view: view)
    }

    /// Creates a `PhysicsObject` with the default setting that it is a rigid body.
    convenience init(view: UIView) {
        self.init(isRigidBody: true, view: view)
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
        guard isRigidBody && object.isRigidBody else {
            return false
        }
        let sqrX = (center.x - object.center.x) * (center.x - object.center.x)
        let sqrY = (center.y - object.center.y) * (center.y - object.center.y)
        let sqrRadius = (radius + object.radius) * (radius + object.radius)
        return sqrX + sqrY <= sqrRadius * EngineSettings.collisionThreshold
    }

    func onCollideWith(_ object: PhysicsBody?) {
        stop()
        object?.stop()
    }

    func attachTo(_ object: PhysicsBody) {
        guard !isAttachedTo(object) else {
            return
        }
        attachedWith.append(object)
    }

    func isAttachedTo(_ object: PhysicsBody) -> Bool {
        return attachedWith.first { $0 === object } != nil
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
