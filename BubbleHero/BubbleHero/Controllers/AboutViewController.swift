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
    /// Some photos used as stingers.
    private let stingers = [#imageLiteral(resourceName: "studio_brand"), #imageLiteral(resourceName: "cs3217_logo"), #imageLiteral(resourceName: "swift_logo")]
    /// The stinger currently used.
    private var currentStingerIndex = 0
    /// The number of clicks on the current stinger.
    private var clickCount = 0

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// Changes the image when user clicks the brand logo for enough times.
    /// - Parameter sender: The view being clicked.
    @IBAction func brandLogoClicked(_ sender: UIButton) {
        guard currentStingerIndex < stingers.count else {
            return
        }

        if clickCount < currentStingerIndex * 3 {
            clickCount += 1
        } else {
            sender.setImage(stingers[currentStingerIndex], for: .normal)
            currentStingerIndex += 1
            clickCount = 0
        }
    }

    /// Goes back to the last view when back button is pressed.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
