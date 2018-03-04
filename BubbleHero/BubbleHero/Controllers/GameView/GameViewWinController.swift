//
//  GameViewWinController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 04/03/18.
//  Copyright © 2018年 Yunpeng Niu. All rights reserved.
//

import UIKit

class GameViewWinController: UIViewController {
    /// The label for displaying the score.
    @IBOutlet weak var scoreLabel: UILabel!
    /// The name of the level.
    var levelName = ""
    /// The score got.
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// Continues the workflow when the button has been pressed.
    /// - Parameter sender: The button being pressed.
    @IBAction func continueButtonPressed(_ sender: UIButton) {
    }

    /// Updates the text inside the score label.
    private func updateLabel() {
        scoreLabel.text = "Level: \(levelName)  Score: \(score)"
    }
}
