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
        super.init(center: view.center, radius: view.frame.width / 2, isCollidable: true, view: view)
    }

    convenience init(type: BubbleType, view: UIView) {
        self.init(type: type, isSnapping: true, view: view)
    }

    /// Gets the same color neighbors of this `BubbleObject`.
    /// - Returns: An array of same color neighbors if there exists; empty array otherwise.
    func getSameColorNeighbors() -> [BubbleObject] {
        var neighbors: [BubbleObject] = []
        for item in attachedWith {
            if let bubble = item as? BubbleObject {
                neighbors.append(bubble)
            }
        }
        return neighbors.filter { $0.type == type }
    }
}
