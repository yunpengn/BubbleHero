//
//  SettingsController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the settings view, in which the player can set some options.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class SettingsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return false
    }

    /// Goes back to the menu view when back button is pressed.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
