//
//  MenuButton.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines a customized button used for the main menu.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class MenuButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 0.15)
        layer.cornerRadius = frame.width / 9
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        setTitleColor(UIColor.darkGray, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
}
