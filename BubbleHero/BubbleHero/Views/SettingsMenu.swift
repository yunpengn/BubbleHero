//
//  SettingsMenu.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018年 Yunpeng Niu. All rights reserved.
//

import UIKit

class SettingsMenu: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.width * Settings.menuCornerRadius
        layer.borderWidth = Settings.menuBorderWidth
        layer.borderColor = UIColor.white.cgColor
    }
}
