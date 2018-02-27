//
//  Messages.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Defines some messages ready to show to the player.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class Messages {
    /// The title for succeed alert.
    static let succeedAlertTitle = "Succeeded"
    /// The title for fail alert.
    static let failAlertTitle = "Failed"

    /// The confirm title before level design is reset.
    static let resetLevelDesignTitle = "Reset Level Design"
    /// The confirm message before level design is reset.
    static let resetLevelDesignMessage = "Are you sure to reset the level design? "
        + "The current design will be lost irreversibly."

    /// The title for saving level.
    static let saveLevelTitle = "Save Level"
    /// The normal message for saving level.
    static let saveLevelNormalMessage = "Enter a name for this Level"
    /// The normal placeholder for saving level.
    static let saveLevelNormalPlaceholder = "Enter name:"
    /// The prompt message when level name is emtpy.
    static let saveLevelEmptyMessage = "The name cannot be empty."
    /// The prompt placeholder when level name is empty.
    static let saveLevelEmptyPlaceholder = "Enter a non-empty name:"
    /// The prompt message when level name already exists.
    static let saveLevelExistingMessage = "The name already exists. Choose a different one."
    /// The prompt placeholder when level name already exists.
    static let saveLevelExistingPlaceholder = "Enter a different name:"
    /// The message when saving level is successful.
    static let saveLevelSucceed = "The current Level has been saved."

    /// The message when encoding data to JSON format fails.
    static let failEncodeJson = "Couldn't encode data to JSON format."
    /// The message when decoding data from JSON format fails.
    static let failDecodeJson = "Couldn't decode data from JSON format."
    /// The message when a screenshot cannot be taken.
    static let failScreenshot = "Couldn't save a screenshot."

    /// The titel for deleting a level.
    static let deleteLevelTitle = "Delete Level"
    /// The message for deleting a level.
    static let deleteLevelMessage = "Are you sure to delete this level design permanently?"
    /// The message when deleting a level fails.
    static let deleteLevelFailMessage = "Sorry, the level is not deleted correctly."
}
