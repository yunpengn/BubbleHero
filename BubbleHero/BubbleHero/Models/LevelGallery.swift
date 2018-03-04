//
//  LevelGallery.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 `LevelGallery` is an abstract data structure that represents a collection of all
 the previously saved levels.

 Internally, `LevelGallery` uses two arrays to store the data files (in JSON format)
 and screenshot images (in PNG format) respectively. Notice that the file here refers
 to the URL to these documents in local storage, while `LevelGallery` provides access
 point to these documents without worrying about the content.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class LevelGallery {
    /// The URLs to all screenshots saved.
    private var imageURLs: [URL]
    /// The URLs to all level data saved.
    private var dataURLs: [URL]

    /// Creates a new `LevelGallery` by adding all the currently
    init() {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let files = try? FileManager.default.contentsOfDirectory(at: folder,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: []) else {
            fatalError("Couldn't read the document directory.")
        }

        // Gets the urls of the files & screenshoots being saved to.
        imageURLs = files.filter { $0.pathExtension == Settings.extensionNameImage }
        dataURLs = imageURLs.map { imageURL in
            return imageURL.deletingPathExtension().appendingPathExtension(Settings.extensionNameData)
        }
    }

    /// Gets the screenshot image path to the level at a specific index.
    /// - Parameter index: The index of the intended level (zero-based).
    /// - Returns: The URL to the screenshot image.
    func getImagePath(at index: Int) -> URL {
        return imageURLs[index]
    }

    /// Gets the level data path to the level at a specific index.
    /// - Parameter index: The index of the intended level (zero-based).
    /// - Returns: The URL to the level design data.
    func getDataPath(at index: Int) -> URL {
        return dataURLs[index]
    }

    /// Deletes the level at a specific index; does nothing if there is no
    /// level at the specified index.
    /// - Parameter index: The index of the intended level (zero-based).
    func deleteLevel(at index: Int) throws {
        guard index >= 0 && index < numOfLevels else {
            return
        }

        let imagePath = getImagePath(at: index)
        try FileManager.default.removeItem(at: imagePath)
        let dataPath = getDataPath(at: index)
        try FileManager.default.removeItem(at: dataPath)

        imageURLs.remove(at: index)
        dataURLs.remove(at: index)
    }

    /// Counts the number of levels that have been saved previously.
    /// - Returns: the number of levels.
    var numOfLevels: Int {
        return imageURLs.count
    }
}
