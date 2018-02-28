//
//  Double+Random.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import Darwin

/**
 Extension for `Double`, which provides some utility methods to generate
 random numbers of `Double` type.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension Double {
    /// Returns a random number in the range of [0, 1).
    static var random: Double {
        // Notice: Due to legacy reason, arc4random always generate a random
        // number within the range of UInt32 (no matter on 32-bit or 64-bit
        // platform). Thus, it should be divided by UInt32.max
        return Double(arc4random()) / Double(UInt32.max)
    }
}
