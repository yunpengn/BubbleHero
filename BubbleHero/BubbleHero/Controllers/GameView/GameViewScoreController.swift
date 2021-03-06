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
class GameViewScoreController: GameViewScoreControllerDelegate {
    /// The view area of the game.
    private let view: UIView
    /// The current score.
    var score = 0

    /// Creates a new score controller.
    /// - Parameter view: The view area of the game.
    init(view: UIView) {
        self.view = view
    }

    func addScore(for bubble: BubbleObject, by reason: RemoveReason) {
        score += reason.rawValue
        let scoreLabel = ScoreLabel(bubble: bubble.view, score: reason.rawValue)
        view.addSubview(scoreLabel)
    }
}

/**
 An enum indicating the reason why a bubble is removed.
 */
enum RemoveReason: Int {
    case normal = 5
    case star = 10
    case lightning = 12
    case bomb = 15
    case falling = 8

    /// Converts from `RemoveAnimation` to `RemoveReason`.
    /// - Parameter effect: The type of `RemoveAnimation`.
    /// - Returns: The `RemoveReason` converted.
    static func fromEffect(_ effect: RemoveAnimation) -> RemoveReason {
        switch effect {
        case .none:
            return .normal
        case .bomb:
            return .bomb
        case .star:
            return .star
        case .lightning:
            return .lightning
        }
    }
}

/**
 Delegate for `GameViewScoreController`.
 */
protocol GameViewScoreControllerDelegate: AnyObject {
    /// Adds score when a new bubble is removed.
    /// - Parameters:
    ///    - bubble: The bubble being removed.
    ///    - reason: The reason why the bubble is removed.
    func addScore(for bubble: BubbleObject, by reason: RemoveReason)
}
