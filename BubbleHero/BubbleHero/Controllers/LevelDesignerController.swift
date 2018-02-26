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

    /// The `Level` object as the access point to model.
    var level = Level()

    override func viewDidLoad() {
        super.viewDidLoad()
        designerGrid.delegate = self
        designerGrid.dataSource = self
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// Goes back to the menu view when back button is pressed.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
