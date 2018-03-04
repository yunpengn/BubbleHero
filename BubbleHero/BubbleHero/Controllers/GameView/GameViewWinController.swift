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

    /// Updates the text inside the score label.
    private func updateLabel() {
        scoreLabel.text = String(format: Settings.scoreLabelFormat, levelName, score)
    }
}
