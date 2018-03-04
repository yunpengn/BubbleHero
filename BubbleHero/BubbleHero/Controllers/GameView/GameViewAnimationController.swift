//
//  GameViewAnimationController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the animations in the game view.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewAnimationController {
    /// The view area to show animation.
    private let view: UIView
    /// The controller for sound effects.
    private let soundPlayer = SoundEffectController()

    /// Creates an animator with a certain view.
    /// - Parameter view: The view of the controller.
    init(view: UIView) {
        self.view = view
    }

    /// Animates the effect of a bubble according to the reason being removed.
    /// - Parameters:
    ///   - object: The bubble being removed.
    ///   - effect: The type of the effect to animate.
    func animate(object: BubbleObject, effect: RemoveAnimation) {
        let newView = clone(object: object)
        switch effect {
        case .none, .lightning, .star:
            fadeAway(view: newView)
        case .bomb:
            newView.explode()
            soundPlayer.play(.bomb)
        }
    }

    /// Animates the lightning effect.
    /// - Parameter x: The mid-x coordinate of the lightning line.
    func addLightningLine(at x: CGFloat) {
        soundPlayer.play(.thunder)
        let line = LightningLine(midY: x)
        view.addSubview(line)
        line.animate()
    }

    private func clone(object: BubbleObject) -> BubbleView {
        let newView = BubbleView(frame: object.view.frame)
        if !object.isSnapping {
            newView.addBorder()
        }
        newView.image = Helpers.toBubbleImage(of: object.type)
        view.addSubview(newView)
        return newView
    }

    private func fadeAway(view: BubbleView) {
        UIView.animate(withDuration: Settings.fadeAwayDuration, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }
}
