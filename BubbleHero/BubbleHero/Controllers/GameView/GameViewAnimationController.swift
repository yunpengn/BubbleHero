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
    private let view: UIView

    init(view: UIView) {
        self.view = view
    }

    func animate(object: BubbleObject, effect: RemoveAnimation) {
        let newView = clone(object: object)
        switch effect {
        case .none:
            fadeAway(view: newView)
        case .bomb:
            newView.explode()
        case .star:
            fadeAway(view: newView)
        }
    }

    func addLightningLine(at x: CGFloat) {
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
