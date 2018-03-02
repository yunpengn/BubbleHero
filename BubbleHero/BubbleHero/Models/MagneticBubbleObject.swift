//
//  MagneticBubbleObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 02/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 `MagneticBubbleObject` is a special kind of bubble that is magnetic. A magnetic
 bubble will atract other moving objects, of which the attraction force between
 then is proportional to the square of distance between them. However, notice the
 objects here do not obey Newton's 2nd Law.

 In the imaginary world, attraction force is single-way. In other words, the magnetic
 body will not move. It will only instruct other objects being attracted to move.
 This violates Newton's 3rd Law.

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
        // Gets the unit for the attraction effect (by distance square).
        let sqrX = (center.x - object.center.x) * (center.x - object.center.x)
        let sqrY = (center.y - object.center.y) * (center.y - object.center.y)
        let unit = Settings.magneticConstant / (sqrX + sqrY)

        // Gets the direction of the attraction effect.
        let dx = unit * sqrX / (sqrX + sqrY) * (center.x - object.center.x).sign
        let dy = unit * sqrY / (sqrX + sqrY) * (center.y - object.center.y).sign
        print(dx, dy)
        object.move(by: CGVector(dx: dx, dy: dy))
    }
}
