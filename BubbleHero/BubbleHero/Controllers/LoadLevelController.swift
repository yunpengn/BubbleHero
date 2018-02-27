//
//  LoadLevelController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the level loading view, in which the player can select a level to
 play or edit.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class LoadLevelController: UIViewController {
    /// The URLs to all screenshots saved.
    var imageURLs: [URL] = []
    /// The URLs to all level data saved.
    var dataURLs: [URL] = []

    /// The collection view that shows all saved levels found.
    @IBOutlet weak var levelGallery: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelGallery.delegate = self
        levelGallery.dataSource = self

        // Gets the urls of the files & screenshoots being saved to.
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let files = try? FileManager.default.contentsOfDirectory(at: folder,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: []) else {
            fatalError("Couldn't read the document directory.")
        }
        imageURLs = files.filter { $0.pathExtension == "png" }
        dataURLs = imageURLs.map { imageURL in
            return imageURL.deletingPathExtension().appendingPathExtension("json")
        }
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
