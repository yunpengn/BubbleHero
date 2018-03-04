//
//  GameViewController+Delegate.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 04/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `GameViewController`, which acts as its delegate.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension GameViewController: GameViewControllerDelegate {
    func stopGame() {
        performSegue(withIdentifier: Settings.gameViewWinSegueId, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Settings.gameViewWinSegueId,
            let winController = segue.destination as? GameViewWinController else {
            return
        }
        winController.levelName = levelName
    }
}

/**
 The delegate for `GameViewController`.
 */
protocol GameViewControllerDelegate: AnyObject {
    /// Stops the game and pops up when the time is up.
    func stopGame()
}
