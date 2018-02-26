//
//  LevelDesignerStorageController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class LevelDesignerStorageController {
    /// The main controller for level designer.
    private let viewController: UIViewController
    /// The view representing the level design area.
    private let designArea: UIView

    /// Creates a storage controller for a certain view controller.
    /// - Parameters:
    ///    - viewController: The main controller for level designer.
    ///    - designArea: The view representing the level design area.
    init(for levelDesignerController: UIViewController, designArea: UIView) {
        self.viewController = levelDesignerController
        self.designArea = designArea
    }

    /// Saves a level design to a file decided by the user.
    /// - Parameter level: The level design being saved.
    func saveLevel(level: Level) {
        promptLevelName(level: level,
                        title: "Save Level",
                        message: "Enter a name for this Level",
                        placeholder: "Enter name:")
    }

    func loadLevel(from path: String) -> Level {
        return Level()
    }

    /// Saves the current `Level` to a local file.
    /// - Parameter fileName: The name of the file being saved to.
    private func saveData(for level: Level, to fileName: String) {
        // Asks the user to enter a new name if the name is empty.
        if fileName == "" {
            promptLevelName(level: level,
                            title: "Save Level",
                            message: "The name cannot be empty.",
                            placeholder: "Enter a non-empty name:")
            return
        }

        // Gets the url of the file & screenshoot being saved to.
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let jsonPath = folder.appendingPathComponent(fileName + ".json")
        let imagePath = folder.appendingPathComponent(fileName + ".png")
        // Asks the user to enter a new name if the file already exists.
        if FileManager.default.fileExists(atPath: jsonPath.path)
            || FileManager.default.fileExists(atPath: imagePath.path) {
            promptLevelName(level: level,
                            title: "Save Level",
                            message: "The name already exists. Choose a different one.",
                            placeholder: "Enter a different name:")
            return
        }

        // Encodes the current level data to JSON format.
        guard let jsonData = try? JSONEncoder().encode(level) else {
            showAlertMessage(title: "Failed", message: "Couldn't encode data to JSON format.")
            return
        }

        // Encodes the screenshot of the current level to PNG format.
        guard let imageData = takeScreenShoot(of: designArea) else {
            showAlertMessage(title: "Failed", message: "Couldn't save a screenshot.")
            return
        }

        // Saves both level data and screenshot to local file.
        let savedJson = NSMutableData(data: jsonData)
        savedJson.write(to: jsonPath, atomically: true)
        let savedImage = NSMutableData(data: imageData)
        savedImage.write(to: imagePath, atomically: true)

        // Alerts to user that the saving is successful.
        showAlertMessage(title: "Succeed", message: "The current Level has been saved.")
    }

    /// Takes a screenshot of the area within `view` and converts it to PNG format data.
    /// - Parameter view: The area where the screenshot will be taken.
    /// - Returns: the screenshot in PNG format; nil if the screenshot cannot be taken.
    private func takeScreenShoot(of view: UIView) -> Data? {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return UIImagePNGRepresentation(image)
    }

    /// Prompts the user to enter the name for the current `Level`.
    /// - Parameters:
    ///    - level: The level to be saved.
    ///    - title: The text shown as the title of the prompt dialog.
    ///    - message: The text shown as the main body of the prompt dialog.
    ///    - placeholder: The placeholder shown in the text field.
    private func promptLevelName(level: Level, title: String, message: String, placeholder: String) {
        DialogHelpers.promptInput(in: viewController,
                                  title: title,
                                  message: message,
                                  placeholder: placeholder,
                                  onConfirm: { (input) in
            self.saveData(for: level, to: input)
            return
        })
    }

    /// Shows an alert message to the user.
    /// - Parameters:
    ///    - title: The text shown as the title of the alert dialog.
    ///    - message: The text shown as the main body of the alert dialog.
    private func showAlertMessage(title: String, message: String) {
        DialogHelpers.showAlertMessage(in: viewController, title: title, message: message)
    }
}
