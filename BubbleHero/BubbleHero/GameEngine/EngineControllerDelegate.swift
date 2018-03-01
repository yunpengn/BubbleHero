//
//  EngineControllerDelegate.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

protocol  EngineControllerDelegate {
    /// Handler for the collision between two objects.
    func onCollide(lhs: PhysicsBody, rhs: PhysicsBody?)
}
