//
//  ViewController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 21/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the main menu view, which is also the entry point for the whole
 application.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
