//
//  CannonView.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 An `UIImageView` designated for cannon body.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class CannonView: UIImageView {
    /// An array of images used as the animation spritesheet.
    private static let sprite = Array(0..<12).map { index in
        return #imageLiteral(resourceName: "cannon").slice(index: index, numOfRows: 2, numOfColumns: 6) ?? #imageLiteral(resourceName: "cannon-single")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.anchorPoint = Settings.launchCannonAnchorPoint
        transform = transform.translatedBy(x: 0, y: Settings.launchCannonTransformY)

        image = CannonView.sprite[0]
        animationImages = CannonView.sprite
        animationRepeatCount = 1
    }
}
