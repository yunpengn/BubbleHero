//
//  LevelDesignerController+Gesture.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `LevelDesignerController`, which supports all the gestures happened
 related to the `designerGrid`, such as adding, updating or deleting bubbles.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension LevelDesignerController {
    /// Updates the cell when there is a single tap on a specific cell.
    /// - Parameter sender: The gesture recognizer being triggered.
    @IBAction func handleSingleTapGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            handleUpdateBubble(sender)
        }
    }

    /// Updates the cell when the drag gesture passes by a specific cell.
    /// - Parameter sender: The gesture recognizer being triggered.
    @IBAction func handleDragGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            handleUpdateBubble(sender)
        }
    }

    /// Deletes the bubble when long press is detected on a specific cell.
    /// - Parameter sender: The gesture recognizer being triggered.
    @IBAction func handleLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            handleDeleteBubble(sender)
        }
    }

    /// Given a triggered gesture recognizer, deletes the bubble under the gesture
    /// from the model.
    /// - Parameter sender: The gesture recognizer being triggered.
    private func handleDeleteBubble(_ sender: UIGestureRecognizer) {
        let location = sender.location(in: designerGrid)
        guard let indexPath = designerGrid.indexPathForItem(at: location) else {
            return
        }
        level.deleteBubbleAt(row: indexPath.section, column: indexPath.row)
        designerGrid.reloadItems(at: [indexPath])
    }

    /// Given a triggered gesture recognizer, updates (or may delete) the bubble
    /// under the gesture from the model.
    /// - Parameter sender: The gesture recognizer being triggered.
    private func handleUpdateBubble(_ sender: UIGestureRecognizer) {
        let selectedBubbleButton = PaletteBubbleButton.currentSelected
        // Deletes the bubble if the eraser is selected.
        if selectedBubbleButton == eraser {
            handleDeleteBubble(sender)
            return
        }

        // Gets the location of the cell on which the gesture is.
        let location = sender.location(in: designerGrid)
        guard let indexPath = designerGrid.indexPathForItem(at: location) else {
            return
        }
        let row = indexPath.section
        let column = indexPath.row

        var type: BubbleType? = nil
        if let image = selectedBubbleButton?.backgroundImage(for: .normal) {
            // Fills the cell with a different image if one bubble button is selected.
            type = toBubbleType(image: image)
        } else if let oldBubble = level.getBubbleAt(row: row, column: column) {
            // Cycles the color of a filled cell if no bubble button is selected.
            type = oldBubble.nextColor()
        }

        // Updates the bubble if the type has been changed.
        if let newType = type {
            level.addOrUpdateBubble(newType, row: row, column: column)
            level.addOrUpdateBubble(newType, row: row, column: column)
            designerGrid.reloadItems(at: [indexPath])
        }
    }

    /// Converts from the `UIImage` to `BubbleType`.
    /// - Parameter image: The image that will be shown in the bubble cell.
    /// - Returns: the `BubbleType` value if the image matches one of the
    /// types; nil otherwise.
    private func toBubbleType(image: UIImage) -> BubbleType? {
        switch image {
        case #imageLiteral(resourceName: "bubble-green"):
            return .green
        case #imageLiteral(resourceName: "bubble-orange"):
            return .orange
        case #imageLiteral(resourceName: "bubble-red"):
            return .red
        case #imageLiteral(resourceName: "bubble-blue"):
            return .blue
        default:
            return nil
        }
    }
}
