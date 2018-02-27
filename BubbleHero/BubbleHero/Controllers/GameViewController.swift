//
//  GameViewController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    /// The body of the cannon used to shoot bubble.
    @IBOutlet weak var cannonBody: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cannonBody.image = #imageLiteral(resourceName: "cannon").slice(index: 0, numOfRows: 2, numOfColumns: 6)
    }

    // Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func loadLevel(_ level: Level) {
        
    }
}
