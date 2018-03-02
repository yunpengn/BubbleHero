//
//  MagneticBubbleObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 02/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 `MagneticBubbleObject` is a special kind of bubble that is magnetic.

 - Author: Niu Yunpeng @ CS3217
 - Date: March 2018
 */
class MagneticBubbleObject: BubbleObject, MagneticBody {
    init(view: BubbleView) {
        super.init(type: .magnetic, view: view)
    }

    func attract(object: PhysicsBody) {
        guard !object.isStatic else {
            return
        }
        let sqrX = (center.x - object.center.x) * (center.x - object.center.x)
        let sqrY = (center.y - object.center.y) * (center.y - object.center.y)
        let unit = Settings.magneticConstant / (sqrX + sqrY)
        let delta = CGVector(dx: velocity.dx * unit, dy: velocity.dy * unit)
        move(by: delta)
    }
}
