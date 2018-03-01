//
//  LevelDesignerController+Delegate.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `LevelDesignerController`, which acts as the delegate for itself.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension LevelDesignerController: LevelDesignerControllerDelegate {
    func loadLevel(_ newLevel: Level) {
        level = newLevel
        designerGrid.reloadData()
    }
}

/**
 Provides the ability to act as the delegate for level designer controller
 such that the controller can be notified when something changed.
 */
protocol LevelDesignerControllerDelegate: AnyObject {
    /// Loads a new level into the level designer.
    /// - Parameter newLevel: The new level being loaded.
    func loadLevel(_ newLevel: Level)
}
