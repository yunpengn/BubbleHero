//
//  LevelDesignerSavingController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Manages the functionalities related to saving the level design data to local
 storage file.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class LevelDesignerSavingController {
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
                        title: Messages.saveLevelTitle,
                        message: Messages.saveLevelNormalMessage,
                        placeholder: Messages.saveLevelNormalPlaceholder)
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
                                  onConfirm: { input in
            self.validateFileName(for: level, to: input)
        })
    }

    /// Validates the file name to save level design.
    /// - Parameters:
    ///    - level: The level to be saved.
    ///    - fileName: The name of the file being saved to.
    private func validateFileName(for level: Level, to fileName: String) {
        // Asks the user to enter a new name if the name is invalid.
        if !fileName.match(Settings.fileNameRegex) {
            promptLevelName(level: level,
                            title: Messages.saveLevelTitle,
                            message: Messages.saveLevelInvalidNameMessage,
                            placeholder: Messages.saveLevelInvalidNamePlaceholder)
            return
        }

        // Gets the url of the file & screenshoot being saved to.
        let jsonPath = getJsonPath(to: fileName)
        let imagePath = getImagePath(to: fileName)

        // Asks the user to enter a new name if the file already exists.
        if FileManager.default.fileExists(atPath: jsonPath.path)
            || FileManager.default.fileExists(atPath: imagePath.path) {
            promptLevelName(level: level,
                            title: Messages.saveLevelTitle,
                            message: Messages.saveLevelExistingMessage,
                            placeholder: Messages.saveLevelExistingPlaceholder)
            return
        }

        saveData(for: level, to: fileName)
    }

    /// Saves the current `Level` to a local file.
    /// - Parameters:
    ///    - level: The level to be saved.
    ///    - fileName: The name of the file being saved to.
    private func saveData(for level: Level, to fileName: String) {
        // Gets the url of the file & screenshoot being saved to.
        let jsonPath = getJsonPath(to: fileName)
        let imagePath = getImagePath(to: fileName)

        // Encodes the current level data to JSON format.
        guard let jsonData = try? JSONEncoder().encode(level) else {
            showAlertMessage(title: Messages.failAlertTitle, message: Messages.failEncodeJson)
            return
        }

        // Encodes the screenshot of the current level to PNG format.
        guard let imageData = takeScreenshot(of: designArea) else {
            showAlertMessage(title: Messages.failAlertTitle, message: Messages.failScreenshot)
            return
        }

        // Saves both level data and screenshot to local file.
        let savedJson = NSMutableData(data: jsonData)
        savedJson.write(to: jsonPath, atomically: true)
        let savedImage = NSMutableData(data: imageData)
        savedImage.write(to: imagePath, atomically: true)

        // Alerts to user that the saving is successful.
        showAlertMessage(title: Messages.succeedAlertTitle, message: Messages.saveLevelSucceed)
    }

    /// Takes a screenshot of the area within `view` and converts it to PNG format data.
    /// - Parameter view: The area where the screenshot will be taken.
    /// - Returns: the screenshot in PNG format; nil if the screenshot cannot be taken.
    private func takeScreenshot(of view: UIView) -> Data? {
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

    /// Given a file name, gets the URL to the JSON file.
    /// - Parameter fileName: The name of the JSON file.
    /// - Returns: The URL of the JSON file.
    private func getJsonPath(to fileName: String) -> URL {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return folder.appendingPathComponent(fileName + Settings.extensionNameData)
    }

    /// Given a file name, gets the URL to the PNG image.
    /// - Parameter fileName: The name of the PNG image.
    /// - Returns: The URL of the PNG image.
    private func getImagePath(to fileName: String) -> URL {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return folder.appendingPathComponent(fileName + Settings.extensionNameImage)
    }

    /// Shows an alert message to the user.
    /// - Parameters:
    ///    - title: The text shown as the title of the alert dialog.
    ///    - message: The text shown as the main body of the alert dialog.
    private func showAlertMessage(title: String, message: String) {
        DialogHelpers.showAlertMessage(in: viewController, title: title, message: message)
    }
}
