//
//  BubbleView.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 An `UIImageView` designated for bubbles.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class BubbleView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 2
        removeBorder()
    }

    /// Adds a purple border with a width of 2 around the bubble image.
    func addBorder() {
        layer.borderColor = UIColor.purple.cgColor
    }

    /// Removes the purple border from the bubble image.l
    func removeBorder() {
        layer.borderColor = UIColor.clear.cgColor
    }
}
