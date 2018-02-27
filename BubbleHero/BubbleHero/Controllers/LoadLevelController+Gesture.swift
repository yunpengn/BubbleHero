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
    /// Loads a level when single tap is detected on a specific cell.
    /// - Parameter sender: The gesture recognizer being triggered.
    @IBAction func handleSingleTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: galleryGrid)
        guard let indexPath = galleryGrid.indexPathForItem(at: location) else {
            return
        }
        loadLevel(at: indexPath.row)
    }

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

    /// When a cell is selected, loads a level and either:
    /// - if the previous view is level designer, goes back to level designer view and the
    /// player can continue design based on this previous design;
    /// - else, start the game with this level.
    /// - Parameter sender: The gesture recognizer being triggered.
    private func loadLevel(at index: Int) {
        let dataPath = levelGallery.getDataPath(at: index)
        guard let jsonData = try? Data(contentsOf: dataPath),
            let level = try? JSONDecoder().decode(Level.self, from: jsonData) else {
                DialogHelpers.showAlertMessage(in: self,
                                               title: Messages.failAlertTitle,
                                               message: Messages.failDecodeJson)
                return
        }

        if designerDelegate != nil {
            designerDelegate?.loadLevel(level)
            navigationController?.popViewController(animated: true)
        }
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
