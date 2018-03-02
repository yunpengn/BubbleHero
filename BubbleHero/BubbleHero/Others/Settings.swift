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
    /// The suitable background for buttons (semi-transparent).
    static let menuBackgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 0.15)
    /// The border width for menu buttons
    static let menuBorderWidth = CGFloat(1)
    /// The border width for checkbox buttons
    static let checkboxBorderWidth = CGFloat(5)
    /// The constant coefficient for menu corner radius.
    static let menuCornerRadius = CGFloat(0.15)
    /// The constant coefficient for checkbox button corner radius.
    static let checkboxCornerRadius = CGFloat(0.3)

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
    /// The number of color types of bubbles in the game currently.
    static let numOfColorTypes = UInt32(4)
    /// The number of non-color types of bubbles in the game currently.
    static let numOfNonColorTypes = Settings.numOfTypes - Settings.numOfColorTypes
    /// The inset for level gallery cells.
    static let levelGalleryCellInset = CGFloat(20)
    /// The number of levels to show in level gallery on each row.
    static let levelPerRow = CGFloat(3)
    /// The name for the randomly generated level.
    static let randomLevelName = "???"
    /// The regular expression to check a file name.
    static let fileNameRegex = "[^a-zA-Z0-9_]+"

    /// The identifier for cells in the collection view of level designer scene.
    static let designerCellId = "fillableBubbleCell"
    /// The identifier for cells in the collection view of level gallery.
    static let galleryCellId = "levelGalleryCell"
    /// The identifier for `GameViewController` in main storyboard.
    static let gameViewControllerId = "gameViewController"
    /// The identifier for the segue from menu to setting view.
    static let menuToSettingsSegueId = "menuToSettings"

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
    /// The probability that a bubble is of basic color type.
    static let colorTypeThreshold = 0.9
    /// The number of next bubbles to preview.
    static let numOfPreviewBubbles = 2

    /// The minimum number of same-color bubbles to start removing.
    static let sameColorThreshold = 3
    /// The constant that represents the gravitational force.
    static let gravityConstant = CGFloat(0.6)
    /// The unit for adjusting the position of non-snapping bubbles.
    static let adjustmentUnit = CGFloat(0.05)

    /// Sets the background music to loop infinitely.
    static let musicInfiniteLoop = -1
    /// The file name for background music in menu view.
    static let musicNameMenu = "Now_Its_Time.mp3"
}
