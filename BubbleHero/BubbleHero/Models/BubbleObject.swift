//
//  BubbleGameObject.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class BubbleObject: PhysicsObject {
    let type: BubbleType
    let isSnapping: Bool

    init(type: BubbleType, isSnapping: Bool, view: UIView) {
        self.type = type
        self.isSnapping = isSnapping
        super.init(center: view.center, radius: view.frame.width / 2, isRigidBody: true, view: view)
    }

    convenience init(type: BubbleType, view: UIView) {
        self.init(type: type, isSnapping: true, view: view)
    }

    override func onCollideWith(_ object: PhysicsBody?) {
        super.onCollideWith(object)
        if isSnapping {
            snapToNearbyCell()
        }
    }

    /// Finds the position of the nearby cell and moves to it.
    private func snapToNearbyCell() {
        let minY = max(center.y - radius, 0)
        let row = round((minY) / FillableBubbleCell.height)
        let newY = row * FillableBubbleCell.height + radius

        let leftOffset = (Int(row) % 2 == 0) ? 0 : FillableBubbleCell.leftOffset
        let minX = max(center.x - radius, leftOffset)
        let column = round((minX - leftOffset) / FillableBubbleCell.diameter)
        let newX = column * FillableBubbleCell.diameter + leftOffset + radius

        move(to: CGPoint(x: newX, y: newY))
    }
}
