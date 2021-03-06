//
//  LevelDesignerController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the level designer view, in which the player can design their
 own customized levels.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class LevelDesignerController: UIViewController {
    /// The collection view used to design the bubble grid.
    @IBOutlet weak var designerGrid: UICollectionView!
    /// The button representation of bubble eraser.
    @IBOutlet weak var eraser: PaletteBubbleButton!
    /// The controller for saving a level.
    private var storageController: LevelDesignerSavingController?
    /// The `Level` object as the access point to model.
    var level = Level()

    override func viewDidLoad() {
        super.viewDidLoad()
        designerGrid.delegate = self
        designerGrid.dataSource = self
        storageController = LevelDesignerSavingController(for: self, designArea: designerGrid)
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "levelDesignerToLoadLevel" else {
            return
        }

        let loadViewController = segue.destination as? LoadLevelController
        loadViewController?.designerDelegate = self
    }

    /// Goes back to the menu view when back button is pressed.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    /// Starts the game when start button is pressed.
    @IBAction func startButtonPressed(_ sender: UIButton) {
        let id = Settings.gameViewControllerId
        guard let gameViewController = storyboard?.instantiateViewController(withIdentifier: id)
            as? GameViewController else {
            fatalError("Could not find the controller for game view")
        }
        gameViewController.level = level
        present(gameViewController, animated: true, completion: nil)
    }

    /// Saves the level design when save button is pressed.
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        storageController?.saveLevel(level: level)
    }

    /// Resets the level design when reset button is pressed.
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        DialogHelpers.promptConfirm(in: self,
                                    title: Messages.resetLevelDesignTitle,
                                    message: Messages.resetLevelDesignMessage,
                                    onConfirm: {
            self.designerGrid.reloadData()
            self.level = Level()
        })
    }
}
