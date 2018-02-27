//
//  PaletteBubbleButton.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines a customized button used for the palette in the level designer. Such
 buttons will look like a bubble and may look quite different when they are
 selected and when they are normal.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class PaletteBubbleButton: UIButton {
    /// Only one of the palette bubbles should be selected at the same time.
    static var currentSelected: PaletteBubbleButton?
    /// Each `PaletteBubbleButton` should correspond to one and only one `BubbleType`.
    var bubbleType: BubbleType?
    /// Acts as an adapter, since @IBInspectable does not support custom type.
    @IBInspectable var bubbleTypeAdapter: Int {
        get {
            return bubbleType?.rawValue ?? -1
        }
        set (typeRawValue) {
            bubbleType = BubbleType(rawValue: typeRawValue)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        applyDeselectEffect(on: self)
    }

    /// Highlights the currently selected button and also makes sure only one
    /// of the `PaletteBubbleButton`s can be selected at the same time.
    /// - Parameter sender: The button that is selected now.
    @objc private func handleButtonPressed(_ sender: PaletteBubbleButton) {
        if sender == PaletteBubbleButton.currentSelected {
            PaletteBubbleButton.currentSelected = nil
            applyDeselectEffect(on: sender)
        } else {
            if let previous = PaletteBubbleButton.currentSelected {
                applyDeselectEffect(on: previous)
            }
            PaletteBubbleButton.currentSelected = sender
            applySelectEffect(on: sender)
        }
    }

    /// Applies the proper effect to highlight a selected button in the palette.
    /// - Parameter button: The button being selected.
    private func applySelectEffect(on button: PaletteBubbleButton) {
        button.alpha = Settings.alphaPaletteBubbleSelected
        button.transform = button.transform.scaledBy(x: Settings.scalePaletteBubbleSelected,
                                                     y: Settings.scalePaletteBubbleSelected)
    }

    /// Reverts the effect applied to a previously selected button in the palette.
    /// - Parameter button: The button being deselected.
    private func applyDeselectEffect(on button: PaletteBubbleButton) {
        button.alpha = Settings.alphaPaletteBubbleNormal
        button.transform = button.transform.scaledBy(x: Settings.scalePaletteBubbleDeselected,
                                                     y: Settings.scalePaletteBubbleDeselected)
    }
}
