//
//  CGFloat+Sign.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 02/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines some helper methods for `CGFloat`.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension CGFloat {
    /// Determines the sign of a `CGFloat`. Returns 1 if it is positive;
    /// 0 if it is zero; -1 otherwise.
    var sign: CGFloat {
        return self > 0 ? 1
                        : (self == 0 ? 0 : -1)
    }
}
