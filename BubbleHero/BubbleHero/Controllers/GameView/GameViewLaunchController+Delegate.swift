//
//  GameViewLaunchController+Delegate.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Extension for `GameViewLaunchController`, which acts as a delegate.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension GameViewLaunchController: GameViewLaunchControllerDelegate {
    func prepareForNextLaunch() {
        readyForLaunch = true
    }
}

/**
 Delegate for `GameViewLaunchController`.
 */
protocol GameViewLaunchControllerDelegate: AnyObject {
    /// Notifies the controller to prepare for the next launch of bubbles.
    func prepareForNextLaunch()
}
