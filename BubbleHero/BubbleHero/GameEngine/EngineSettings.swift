//
//  EngineSettings.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines some global level settings for the game engine.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class EngineSettings {
    /// The threshold value for collision, i.e., we may ignore
    /// "collision" when the gap can let the bubble merely pass
    /// through.
    static let collisionThreshold = CGFloat(0.9)
    /// The threshold for attaching two `BubbleObject`s.
    static let attachmentThreshold = CGFloat(1.05)
}
