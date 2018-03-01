//
//  CheckboxButton.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 A custom button to look and work as a checkbox.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class CheckboxButton: UIButton {
    @IBInspectable var isChecked: Bool = false {
        didSet {
            if isChecked {
                setImage(#imageLiteral(resourceName: "ok-green"), for: .normal)
            } else {
                setImage(nil, for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Settings.menuBackgroundColor
        layer.cornerRadius = frame.width * Settings.checkboxCornerRadius
        layer.borderWidth = Settings.checkboxBorderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        setImage(nil, for: .normal)
        addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
    }

    /// Toggles between selected and not selected.
    /// - Parameter sender: The button that is selected now.
    @objc
    private func handleButtonPressed(_ sender: CheckboxButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
