//
//  MagneticBody.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 02/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 `MagneticBody` is a special kind of `PhysicsBody` that obeys a (simplified form
 of) Coulomb's law. Due to Coulomb force, there exists a varying attraction between
 a `MagneticBody` and a non-static `PhysicsBody`, whose magnitude is dependent on
 the distance between them.

 - Author: Niu Yunpeng @ CS3217
 - Date: March 2018
 */
protocol MagneticBody: PhysicsBody {
    /// Decides whether this magnetic body can attract other bodies now, whose
    /// default value is true.
    var isAttractable: Bool { get set }

    /// Attracts another `PhysicsBody` by moving its position.
    /// - Parameter object: The object being attracted.
    func attract(object: PhysicsBody)
}
