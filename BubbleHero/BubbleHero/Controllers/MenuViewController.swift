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
        
    }
}
