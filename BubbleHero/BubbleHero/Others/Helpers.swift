//
//  Helpers.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines some generic useful helper methods for the application.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class Helpers {
    /// Gets an image of the bubble cell according to its type.
    /// - Parameter type: The type of the bubble
    /// - Returns: The background image corresponding to this type.
    static func toBubbleImage(of type: BubbleType) -> UIImage {
        switch type {
        case .blue:
            return #imageLiteral(resourceName: "bubble-blue")
        case .green:
            return #imageLiteral(resourceName: "bubble-green")
        case .orange:
            return #imageLiteral(resourceName: "bubble-orange")
        case .red:
            return #imageLiteral(resourceName: "bubble-red")
        case .indestructible:
            return #imageLiteral(resourceName: "bubble-indestructible")
        case .lightning:
            return #imageLiteral(resourceName: "bubble-lightning")
        case .magnetic:
            return #imageLiteral(resourceName: "bubble-magnetic")
        case .star:
            return #imageLiteral(resourceName: "bubble-star")
        case .bomb:
            return #imageLiteral(resourceName: "bubble-bomb")
        }
    }

    /// Creates a `BubbleObject` from a certain bubble type and its information.
    /// - Parameters:
    ///    - type: The type of this bubble.
    ///    - isSnapping: Indicates whether this bubble is a snapping bubble.
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    /// - Returns: The `BubbleObject` created.
    static func toBubbleObject(type: BubbleType, isSnapping: Bool, row: Int, column: Int) -> BubbleObject {
        /// Gets the origin for the view.
        let y = FillableBubbleCell.height * CGFloat(row)
        let offset = (row % 2 == 0) ? 0 : FillableBubbleCell.leftOffset
        let x = FillableBubbleCell.diameter * CGFloat(column) + offset

        /// Creates a `BubbleView` object.
        let diameter = FillableBubbleCell.diameter
        let view = BubbleView(frame: CGRect(x: x, y: y, width: diameter, height: diameter))
        view.image = toBubbleImage(of: type)
        if !isSnapping {
            view.addBorder()
        }

        return BubbleObject(type: type, isSnapping: isSnapping, view: view)
    }

    /// Creates a snapping `BubbleObject` from a certain bubble type and its information.
    /// - Parameters:
    ///    - type: The type of this bubble.
    ///    - row: The row number of the intended location (zero-based).
    ///    - column: The column number of the intended location (zero-based).
    /// - Returns: The snapping `BubbleObject` created.
    static func toBubbleObject(type: BubbleType, row: Int, column: Int) -> BubbleObject {
        return toBubbleObject(type: type, isSnapping: true, row: row, column: column)
    }
}
