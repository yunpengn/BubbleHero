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

 In addition, collision can only happen between two rigid bodies. This idea of "rigid
 body" is inspired by Unity3d game engine.

 ## Attraction:
 Any `MagneticPhysicsBody` can attract other objects. Due to the natural of the application,
 the calculation here is a bit different from the actual physics. A `MagnetricPhysicsBody`
 will actually move every moving object by a certain distance.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class PhysicsEngine2D {
    /// A list of all `PhysicsBody`s controlled by this `PhysicsEngine`.
    private var physicsObjects: [PhysicsBody] = []
    /// The area for this physics engine, in which all `PhysicsBody`s should reside.
    private let area: CGRect
    /// The delegate for the game engine it belongs to.
    var gameEngine: GameEngineDelegate?

    /// Creates a physics engine with a certain area.
    /// - Parameters:
    ///    - area: The area for the physics engine.
    ///    - gameEngine: The delegate for the game engine.
    init(area: CGRect) {
        self.area = area
    }

    func update() {
        for object in physicsObjects {
            guard !object.isStatic else {
                continue
            }
            object.move()
            checkHorizontalReflect(of: object)
            checkTouchButtom(of: object)
            checkTouchTop(of: object)
            checkCollision(of: object)
        }
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

    /// Removes the `PhysicsBody` when it touches the buttom of the screen.
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkTouchButtom(of object: PhysicsBody) {
        if object.center.y + object.radius >= area.maxY {
            object.stop()
            deregisterPhysicsObject(object)
        }
    }

    /// Stops the `PhysicsBody` and notifies when it touches the top of the screen.
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkTouchTop(of object: PhysicsBody) {
        if object.center.y - object.radius <= 0 {
            object.onCollideWith(nil)
        }
    }

    /// Checks whether this `PhysicsBody` collides with any other `PhysicsBody`
    /// registered in the same `PhysicsEngine`.
    /// - Parameter object: The `PhysicsBody` being checked.
    private func checkCollision(of object: PhysicsBody) {
        for otherObject in physicsObjects {
            // Notice: Here, the lhs object is the one that is moving and actively causes
            // the collision. The rhs object is static and waiting for being crashed.
            if otherObject !== object && object.willCollideWith(otherObject) {
                object.onCollideWith(otherObject)
            }
        }
    }

    /// Registers a new `GameObject` into this `PhysicsEngine`. The movement
    /// and collision detection of this `GameObject` will be managed by this
    /// `PhysicsEngine` from now on.
    /// - Parameter toRegister: The `PhysicsObject` being registered.
    func registerPhysicsObject(_ toRegister: PhysicsBody) {
        physicsObjects.append(toRegister)
    }

    /// Deregisters a `PhysicsObject` from this `PhysicsEngine`, who will not be in
    /// charge of its movement and collision detection from on.
    /// - Parameter toDeregister: The `PhysicsObject` being deregistered.
    func deregisterPhysicsObject(_ toDeregister: PhysicsBody) {
        physicsObjects = physicsObjects.filter { $0 !== toDeregister }
        if let object = toDeregister as? PhysicsObject {
            gameEngine?.deregisterPhysicsObject(object)
        }
    }
}
