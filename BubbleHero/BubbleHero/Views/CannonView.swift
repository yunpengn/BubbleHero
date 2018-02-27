//
//  CannonView.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class CannonView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.anchorPoint = Settings.launchCannonAnchorPoint
        transform = transform.translatedBy(x: 0, y: Settings.launchCannonTransformY)
    }
}
