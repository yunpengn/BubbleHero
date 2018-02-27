//
//  AboutViewController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the game view, which shows some information about the game.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class AboutViewController: UIViewController {
    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// Goes back to the last view when back button is pressed.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
