//
//  GameViewLaunchController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the bubble launcher in game view, which assists `GameViewController`
 for functionalities related to bubble launch and cannon update.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewLaunchController {
    /// The view for cannon which can visually shoot a bubble.
    private let cannon: UIView

    init(cannon: UIView) {
        self.cannon = cannon
    }

    /// Rotates the cannon body so that it faces a certain point.
    /// - Parameter point: The point that the cannon is supposed to face.
    func rotateCannon(to point: CGPoint) {

    }
}
