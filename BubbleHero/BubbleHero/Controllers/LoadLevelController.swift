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
    /// The collection view that shows all saved levels found.
    @IBOutlet weak var galleryGrid: UICollectionView!
    /// The model representation of all previously saved levels.
    let levelGallery = LevelGallery.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryGrid.delegate = self
        galleryGrid.dataSource = self
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
