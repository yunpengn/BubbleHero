//
//  ScoreLabel.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 04/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines a customized label used to display scores added.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class ScoreLabel: UILabel {
    /// Creates a score label for a certain bubble.
    /// - Parameters:
    ///    - bubble: The bubble to show label on.
    ///    - score: The score as the text of the label.
    init(bubble: UIView, score: Int) {
        super.init(frame: bubble.frame)
        center = bubble.center
        text = "+\(score)"
        textColor = UIColor.white
        UIView.animate(withDuration: Settings.scoreLabelDuration, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
