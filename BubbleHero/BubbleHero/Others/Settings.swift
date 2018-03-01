//
//  Settings.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines some global level settings for the application.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class Settings {
    /// The alpha value for bubble buttons in the palette when it is selected.
    static let alphaPaletteBubbleSelected = CGFloat(1)
    /// The alpha value for bubble buttons in the palette when it is not selected.
    static let alphaPaletteBubbleNormal = CGFloat(0.5)
    /// The alpha value for bubble cells in the designer grid when it is empty.
    static let alphaBubbleCellEmpty = CGFloat(0.6)
    /// The alpha value for bubble cells in the designer grid when it is filled.
    static let alphaBubbleCellFilled = CGFloat(1)
    /// The `CGAffineTransform` scale for bubble buttons in the palette when it is selected.
    static let scalePaletteBubbleSelected = CGFloat(1.1)
    /// The reverse scale for bubble buttons in the palette when it is selected.
    static let scalePaletteBubbleDeselected = 1 / Settings.scalePaletteBubbleSelected

    /// The allowed number of rows in a `Level`.
    static let numOfRows = 12
    /// The allowed number of bubbles on even rows.
    static let cellPerRow = 12
    /// The number of types of bubbles in the game currently.
    static let numOfTypes = UInt32(9)
    /// The number of basic types of bubbles in the game currently.
    static let numOfBasicTypes = UInt32(4)
    /// The inset for level gallery cells.
    static let levelGalleryCellInset = CGFloat(20)
    /// The number of levels to show in level gallery on each row.
    static let levelPerRow = CGFloat(3)

    /// The identifier for cells in the collection view of level designer scene.
    static let designerCellId = "fillableBubbleCell"
    /// The identifier for cells in the collection view of level gallery.
    static let galleryCellId = "levelGalleryCell"
    /// The identifier for `GameViewController` in main storyboard.
    static let gameViewControllerId = "gameViewController"

    /// The extension file name for data storage.
    static let extensionNameData = ".json"
    /// The extension file name for image storage.
    static let extensionNameImage = ".png"

    /// To avoid the user from shooting a bubble with nearly the angle of 0/180 degrees.
    static let launchVerticalLimit = CGFloat(60)
    /// The anchor point for the launch cannon.
    static let launchCannonAnchorPoint = CGPoint(x: 0.5, y: 0.9)
    /// The offset transform for the launch cannon.
    static let launchCannonTransformY = CGFloat(50)

    /// The speed in which the shooting bubble will travel.
    static let shootSpeed = CGFloat(15)
    /// The probability that the shooted bubble is snapping.
    static let snappingThreshold = 0.9
    /// The number of next bubbles to preview.
    static let numOfPreviewBubbles = 2

    /// The minimum number of same-color bubbles to start removing.
    static let sameColorThreshold = 3
}
