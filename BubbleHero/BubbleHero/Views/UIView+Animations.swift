//
//  UIView+Animations.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `UIView`, which provides some helper methods for animations.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension UIView {
    /// Applies fade away effect on this view.
    /// - Parameter handler: The handler when the effect has completed.
    func fadeAway(onComplete handler: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0
        }, completion: handler)
    }
}
