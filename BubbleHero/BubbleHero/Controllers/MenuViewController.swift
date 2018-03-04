//
//  ViewController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 21/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the main menu view, which is also the entry point for the whole
 application.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class MenuViewController: UIViewController {
    /// The controller for background music.
    private var musicController: BackgroundMusicController?

    override func viewDidLoad() {
        super.viewDidLoad()
        musicController = BackgroundMusicController(for: Settings.musicNameMenu)
        checkPreloadLevels()
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Settings.menuToSettingsSegueId,
            let controller = segue.destination as? SettingsController {
            controller.musicController = musicController
        }
    }

    /// Checks whether the pre-loaded levels have been loaded before.
    private func checkPreloadLevels() {
        guard UserDefaults.standard.string(forKey: Settings.preloadLevelKey) == nil else {
            return
        }
        Settings.preloadData.forEach { loadData($0) }
        UserDefaults.standard.set(true, forKey: Settings.preloadLevelKey)
    }

    /// Loads the data from a certain file name into the document directory.
    /// - Parameter fileName: The file name of loaded data.
    private func loadData(_ fileName: String) {
        /// The URL we copy data from.
        guard let from = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            return
        }
        /// The URL we will copy data to.
        var to = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        to.appendPathComponent(fileName)

        /// Copies the item over.
        do {
            try FileManager.default.copyItem(at: from, to: to)
        } catch {
            DialogHelpers.showAlertMessage(in: self,
                                           title: Messages.failAlertTitle,
                                           message: Messages.failPreloadMessage)
        }
    }
}
