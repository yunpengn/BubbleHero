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
 movement and collision detection.

 ## Object movement:
 Any object can start moving by giving it an initial speed or giving it an initial
 acceleration. Notice that since `GameObject` does not have a mass, it will not obey
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

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class PhysicsEngine2D {
    /// A list of all `PhysicsObject`s controlled by this `PhysicsEngine`.
    private var physicsObjects: [PhysicsBody] = []

    func update() {
        
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
    }
}
