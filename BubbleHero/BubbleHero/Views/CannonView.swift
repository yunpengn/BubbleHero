//
//  CannonView.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class CannonView: UIImageView {
    static let sprite = Array(0..<12).map { index in
        return #imageLiteral(resourceName: "cannon").slice(index: index, numOfRows: 2, numOfColumns: 6) ?? #imageLiteral(resourceName: "cannon-single")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.anchorPoint = Settings.launchCannonAnchorPoint
        transform = transform.translatedBy(x: 0, y: Settings.launchCannonTransformY)

        image = CannonView.sprite[0]
        animationImages = CannonView.sprite
    }
}
