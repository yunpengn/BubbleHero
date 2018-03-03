//
//  GameViewAnimationController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class GameViewAnimationController {
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
        
    }

    private func clone(object: BubbleObject) -> BubbleView {
        let newView = BubbleView(frame: object.view.frame)
        if !object.isSnapping {
            newView.addBorder()
        }
        object.view.superview?.addSubview(newView)
        return newView
    }

    private func fadeAway(view: BubbleView) {
        UIView.animate(withDuration: Settings.fadeAwayDuration,
                       delay: 0.1, options: .curveEaseOut, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }
}
