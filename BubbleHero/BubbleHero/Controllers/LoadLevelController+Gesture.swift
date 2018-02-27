//
//  LoadLevelController+Gesture.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `LoadLevelController`, which supports all the gestures happened
 related to the `galleryGrid`, such as loading or deleting levels.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension LoadLevelController {
    /// Deletes the level when long press is detected on a specific cell.
    /// - Parameter sender: The gesture recognizer being triggered.
    @IBAction func handleLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: galleryGrid)
        guard let indexPath = galleryGrid.indexPathForItem(at: location) else {
            return
        }

        DialogHelpers.promptConfirm(in: self,
                                    title: Messages.deleteLevelTitle,
                                    message: Messages.deleteLevelMessage,
                                    onConfirm: {
            self.deleteLevel(at: indexPath.row)
        })
    }

    /// Deletes the level at a specific index.
    /// - Parameter index: The index of the level being deleted.
    private func deleteLevel(at index: Int) {
        do {
            try levelGallery.deleteLevel(at: index)
            galleryGrid.reloadData()
        } catch {
            DialogHelpers.showAlertMessage(in: self,
                                           title: Messages.failAlertTitle,
                                           message: Messages.deleteLevelFailMessage)
        }
    }
}
