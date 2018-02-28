//
//  PhysicsObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Each object registered in the `PhysicsEngine` must be a `PhysicsObject`. A
 `PhysicsObject` is a `GameObject`, which conforms to the `PhysicsBody`
 protocol. Thus, it possesses some physics properties, like position, velocity
 & acceleration, etc.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class PhysicsObject: GameObject, PhysicsBody {
    /// The current acceleration of the `GameObject`, whose initial value is (0, 0).
    var acceleration = CGVector.zero
    /// The current speed of the `GameObject`, whose initial value is (0, 0).
    var speed = CGVector.zero
    /// The coordinate of the center of the `GameObject`.
    var center: CGPoint
    /// The radius of the `GameObject`.
    let radius: CGFloat
    /// Indiciates whether the `GameObject` is a rigid body.
    let isRigidBody: Bool

    /// Creates a `PhysicsObject` by associating it with a `UIView` object.
    /// - Parameters:
    ///    - center: The coordinate for the center of the `GameObject`.
    ///    - radius: The radius of this `GameObject`.
    ///    - isRigidBody: Indicates whether this `GameObject` is a rigid body.
    ///    - view: The `UIView` object associated with.
    init(center: CGPoint, radius: CGFloat, isRigidBody: Bool, view: UIView) {
        self.center = center
        self.radius = radius
        self.isRigidBody = isRigidBody
        super.init(view: view)
    }

    /// Creates a `GameObject` with the default setting that its visual center is its
    /// actual center.
    convenience init(radius: CGFloat, isRigidBody: Bool, view: UIView) {
        let center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        self.init(center: center, radius: radius, isRigidBody: isRigidBody, view: view)
    }

    /// Creates a `GameObject` with the default setting that it is a rigid body.
    convenience init(radius: CGFloat, view: UIView) {
        self.init(radius: radius, isRigidBody: true, view: view)
    }

    func move() {
        // Applies changes to the `GameObject`'s location.
        move(by: speed)
        // Applies changes to the `GameObject`'s speed.
        speed = CGVector(dx: speed.dx + acceleration.dx, dy: speed.dy + acceleration.dy)
    }

    func move(by delta: CGVector) {
        center = CGPoint(x: center.x + speed.dx, y: center.y + speed.dy)
    }

    func move(to point: CGPoint) {
        center = point
    }

    func stop() {
        speed = CGVector.zero
        acceleration = CGVector.zero
    }

    func brake() {
        speed = CGVector.zero
    }

    func reflectX() {
        speed = CGVector(dx: -speed.dx, dy: speed.dy)
    }

    func reflectY() {
        speed = CGVector(dx: speed.dx, dy: -speed.dy)
    }

    var isStatic: Bool {
        return speed == CGVector.zero && acceleration == CGVector.zero
    }
}
