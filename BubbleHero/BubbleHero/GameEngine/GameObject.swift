//
//  GameObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Each object registered in the `PhysicsEngine` must be a `GameObject`. A
 `GameObject` can either be static or be moving.

 For simplicity, a `GameObject` is modelled as a 2D perfect circle, with a
 constant area, but without volume or mass.

 To display a `GameObject`, it should be associated with a `UIView` object.
 Although the `UIView` object may not be visually shown as a perfect circle,
 its shape will not be taken into consideration. However, the content of its
 `frame` will be changed such that the movement of the `GameObject` can be
 observed by the user.

 Notice that the speed and acceleration of a `GameObject` is modelled as a
 `CGVector`, whose `dx` and `dy` will correspond to its speed/acceleration on
 the x/y axis. The speed/acceleration here is in the unit of a frame, i.e.,
 the change in location/speed per display link's frame. By default, `CADisplayLink`'s
 frame rate is 60 frames per second.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameObject {
    /// The current acceleration of the `GameObject`, whose initial value is (0, 0).
    var acceleration = CGVector.zero
    /// The current speed of the `GameObject`, whose initial value is (0, 0).
    var speed = CGVector.zero
    /// The coordinate of the center of the `GameObject`.
    var center: CGVector
    /// The radius of the `GameObject`.
    let radius: CGFloat
    /// Indiciates whether the `GameObject` is a rigid body.
    let isRigidBody: Bool
    /// The `UIView` object associated with this `GameObject`.
    private let view: UIView

    /// Creates a `GameObject` by associating it with a `UIView` object.
    /// - Parameters:
    ///    - center: The coordinate for the center of the `GameObject`.
    ///    - radius: The radius of this `GameObject`.
    ///    - isRigidBody: Indicates whether this `GameObject` is a rigid body.
    ///    - view: The `UIView` object associated with.
    init(center: CGVector, radius: CGFloat, isRigidBody: Bool, view: UIView) {
        self.center = center
        self.radius = radius
        self.isRigidBody = isRigidBody
        self.view = view
    }

    /// Creates a `GameObject` with the default setting that its visual center is its
    /// actual center.
    convenience init(radius: CGFloat, isRigidBody: Bool, view: UIView) {
        let center = CGVector(dx: view.frame.midX, dy: view.frame.midY)
        self.init(center: center, radius: radius, isRigidBody: isRigidBody, view: view)
    }

    /// Creates a `GameObject` with the default setting that it is a rigid body.
    convenience init(radius: CGFloat, view: UIView) {
        self.init(radius: radius, isRigidBody: true, view: view)
    }

    /// Moves the `GameObject` by its current speed. If the current acceleration is
    /// not 0, its speed will be changed accordingly as well. Notice that this method
    /// should be called per frame.
    func move() {
        // Applies changes to the `GameObject`'s location.
        center = CGVector(dx: center.dx, dy: center.dy)
        // Applies changes to the `GameObject`'s speed.
        speed = CGVector(dx: speed.dx + acceleration.dx, dy: speed.dy + acceleration.dy)
    }

    /// Stops a `GameObject` by setting its speed and acceleration both to (0, 0).
    func stop() {
        speed = CGVector.zero
        acceleration = CGVector.zero
    }

    /// Applies an instantaneous brake to the `GameObject` by settings its speed to (0, 0)
    /// without affecting its acceleration.
    func brake() {
        speed = CGVector.zero
    }

    /// Reverses the x-component of the speed to simulate a horizontal "reflect".
    func reflectX() {
        speed = CGVector(dx: -speed.dx, dy: speed.dy)
    }

    /// Reverses the y-component of the speed to simulate a vertical "reflect".
    func reflectY() {
        speed = CGVector(dx: speed.dx, dy: -speed.dy)
    }

    /// Indicates whether a `GameObject` is static by checking whether its current speed
    /// and acceleration are both (0, 0).
    var isStatic: Bool {
        return speed == CGVector.zero && acceleration == CGVector.zero
    }
}
