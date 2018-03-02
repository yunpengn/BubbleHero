//
//  EngineControllerDelegate.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 The controller for a physics engine should conform this protocol so that
 collision between physical objects can be handled properly.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
protocol  EngineControllerDelegate {
    /// Handler for the collision between two objects.
    func onCollide(lhs: PhysicsBody, rhs: PhysicsBody?)
}
