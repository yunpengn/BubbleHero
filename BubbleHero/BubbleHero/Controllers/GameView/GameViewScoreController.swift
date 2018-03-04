//
//  GameViewScoreController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 04/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the score calculation in the game view.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewScoreController {
    /// The view area of the game.
    private let view: UIView
    /// The current score.
    var score = 0

    /// Creates a new score controller.
    /// - Parameter view: The view area of the game.
    init(view: UIView) {
        self.view = view
    }

    func addScore(for bubble: BubbleObject, by reason: RemoveAnimation) {
        
    }
}
