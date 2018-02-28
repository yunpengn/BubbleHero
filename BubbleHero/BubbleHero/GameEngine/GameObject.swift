//
//  GameObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Each object registered in the `GameEngine` must be a `GameObject`. It has
 a view associated with it.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameObject {
    /// The `UIView` object associated with this `GameObject`.
    let view: UIView

    /// Creates a `PhysicsObject` by associating it with a `UIView` object.
    /// - Parameter view: The `UIView` object associated with.
    init(view: UIView) {
        self.view = view
    }
}
