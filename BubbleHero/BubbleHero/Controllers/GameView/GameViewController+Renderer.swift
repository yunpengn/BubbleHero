//
//  GameViewController+Renderer.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import GameEngine

/**
 Extension for `GameViewController`, which provides related functionalities to work
 as a `Renderer`.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension GameViewController: Renderer {
    func render(for object: PhysicsBody) {
        object.view.center = object.center
    }

    func appear(_ object: PhysicsBody) {
        view.addSubview(object.view)
    }

    func disappear(_ object: PhysicsBody) {
        object.view.removeFromSuperview()
    }
}
