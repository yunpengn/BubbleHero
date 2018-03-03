//
//  LightningLine.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class LightningLine: UIView {
    init(midY: CGFloat) {
        let minY = midY - Settings.lightningLineHeight / 2
        let width = UIScreen.main.bounds.width
        super.init(frame: CGRect(x: 0, y: minY, width: width, height: Settings.lightningLineHeight))
        backgroundColor = UIColor.white
        alpha = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func animate() {
        UIView.animate(withDuration: Settings.lightningDuration, animations: {
            self.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: Settings.lightningDuration, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        })
    }
}
