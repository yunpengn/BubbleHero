//
//  WinViewButton.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 04/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines a customized button used for the game winning view.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class WinViewButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Settings.winButtonsColor
        layer.cornerRadius = frame.width * Settings.buttonCornerRadius
        layer.borderWidth = Settings.winBorderWidth
        layer.borderColor = UIColor.darkGray.cgColor
        setTitleColor(UIColor.darkGray, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
}
