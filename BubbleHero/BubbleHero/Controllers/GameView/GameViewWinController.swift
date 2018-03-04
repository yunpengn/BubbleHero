//
//  GameViewWinController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 04/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class GameViewWinController: UIViewController {
    /// The label for displaying the score.
    @IBOutlet private weak var scoreLabel: UILabel!
    /// The name of the level.
    var levelName = ""
    /// The score got.
    var score = 0
    /// The navigation passed in order to clear all previous scenes.
    var navigation: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Level: \(levelName)  Score: \(score)"
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// Continues (and restarts) the workflow when the button has been pressed.
    /// - Parameter sender: The button being pressed.
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        navigation?.popToRootViewController(animated: true)
    }
}
