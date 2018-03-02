//
//  PhysicsEngine2D.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 This class implements a simplified 2D physics engine which supports simple object
 movement, collision detection and attraction (according to Coulomb's law).

 ## Object movement:
 Any object can start moving by giving it an initial speed or giving it an initial
 acceleration. Notice that since `PhysicsBody` does not have a mass, it will not obey
 Newton's 2nd law and thus all acceleration must be explicitly given rather than derived
 from an external force.

 Notice that since we are in the 2D world, gravitational field is not taken into
 consideration. However, the gavitational force can be modelled by manually giving the
 object an acceleration equal to the gravitational constant. Also, the direction of the
 gravity here is not naturally "downwards" as well.

 ## Collision detection:
 Since we only consider the 2D world, all objects only has size, but not volume. Also,
 all objects are modelled as a perfect circle. Thus, we can simply compare the distance
 between the centers of two objects with the sum of their radii to check whether any
 collision occurs between them.

 In addition, collision can only happen between two collidable bodies. This concept is
 inspired by Unity3d game engine.

 ## Attraction:
 Any `MagneticPhysicsBody` can attract other objects. Due to the natural of the application,
 the calculation here is a bit different from the actual physics. A `MagnetricPhysicsBody`
 will actually move every moving object by a certain distance.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class PhysicsEngine2D {
    /// A list of all `PhysicsBody`s controlled by this `PhysicsEngine`.
    var physicsObjects: [PhysicsBody] = []
    /// The rendering engine for this game engine.
    private let renderer: Renderer
    /// The area for this physics engine, in which all `PhysicsBody`s should reside.
    private let area: CGRect
    /// The delegate for the controller.
    var controllerDelegate: EngineControllerDelegate?

    /// Creates a new physics engine by attaching a rending engine to it.
    /// - Parameters:
    ///    - renderer: The rendering engine for the game engine.
    ///    - area: The area for the game engine.
    init(renderer: Renderer, area: CGRect) {
        self.renderer = renderer
        self.area = area

        let displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
    }

    /// A "step" that each registered `PhysicsBody` should perform per frame of the
    /// `CADisplayLink`, which will in turn be controlled by the physics engine and
    /// rendering engine.
    /// - Parameter displayLink: The timer object that synchronizes the drawing to
    /// the refresh rate of the display.
    @objc
    private func step(displayLink: CADisplayLink) {
        for object in physicsObjects {
            if let body = object as? MagneticBody {
                attract(by: body)
            }
            guard !object.isStatic else {
                continue
            }
            object.move()
            checkHorizontalReflect(of: object)
            checkTouchBottom(of: object)
            checkTouchTop(of: object)
            checkCollision(of: object)
            renderer.render(for: object)
        }
    }

    /// Applies the attraction effect by a magnetic object.
    /// - Parameter object: The object that is magnetic.
    private func attract(by object: MagneticBody) {
        physicsObjects.forEach { object.attract(object: $0) }
    }

    /// Reflects (by reversing the x-component of its speed) when it touches the left
    /// or right side of the screen (acting as the "wall").
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkHorizontalReflect(of object: PhysicsBody) {
        let center = object.center.x
        if center - object.radius <= 0 || center + object.radius >= area.maxX {
            object.reflectX()
        }
    }

    /// Removes the `PhysicsBody` when it touches the bottom of the screen.
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkTouchBottom(of object: PhysicsBody) {
        if object.center.y + object.radius >= area.maxY {
            object.stop()
            deregisterPhysicsObject(object)
        }
    }

    /// Stops the `PhysicsBody` and notifies when it touches the top of the screen.
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkTouchTop(of object: PhysicsBody) {
        if object.center.y - object.radius <= 0 {
            controllerDelegate?.onCollide(lhs: object, rhs: nil)
        }
    }

    /// Checks whether this `PhysicsBody` collides with any other `PhysicsBody`
    /// registered in the same `PhysicsEngine`.
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkCollision(of object: PhysicsBody) {
        for otherObject in physicsObjects {
            // Notice: Here, the lhs object is the one that is moving and actively causes
            // the collision. The rhs object is static and waiting for being crashed.
            if otherObject !== object && object.didCollideWith(otherObject) {
                controllerDelegate?.onCollide(lhs: object, rhs: otherObject)
            }
        }
    }

    /// Registers a new `PhysicsBody` into this engine, which will be managed
    /// by the game engine from now on. You should deregister this `PhysicsBody`
    /// before you call this method if it has been registered into any other engine
    /// before.
    /// - Parameter toRegister: The `PhysicsBody` being registered.
    func registerPhysicsObject(_ toRegister: PhysicsBody) {
        physicsObjects.append(toRegister)
        renderer.appear(toRegister)
    }

    /// Registers an array of `PhysicsBody`s into this engine.
    /// - Parameter contentsOf: The `PhysicsBody`s being registered.
    func registerPhysicsObject(contentsOf: [PhysicsBody]) {
        contentsOf.forEach { registerPhysicsObject($0) }
    }

    /// Deregisters a `PhysicsBody` from this engine, which will not be managed
    /// by the game engine anymore. This method will do nothing if the `PhysicsBody`
    /// was not registered with this engine before.
    /// - Parameter toDeregister: The `PhysicsBody` being deregistered.
    func deregisterPhysicsObject(_ toDeregister: PhysicsBody) {
        physicsObjects = physicsObjects.filter { $0 !== toDeregister }
        renderer.disappear(toDeregister)
    }

    /// Deregisters an array of `PhysicsBody`s from this engine.
    /// - Parameter contentsOf: The `PhysicsBody`s being deregistered.
    func deregisterPhysicsObject(contentsOf: [PhysicsBody]) {
        contentsOf.forEach { deregisterPhysicsObject($0) }
    }
}
