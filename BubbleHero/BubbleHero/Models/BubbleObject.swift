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
    /// The type of this bubble.
    let type: BubbleType
    /// Indicates whether the bubble is a snapping bubble.
    var isSnapping: Bool
    /// Indicates whether the bubble is attached to the top wall (either directly or indirectly).
    var isAttachedToTop = false
    /// Assists the traversal when checking unattached bubbles.
    var visited = false

    init(type: BubbleType, isSnapping: Bool, view: UIView) {
        self.type = type
        self.isSnapping = isSnapping
        super.init(center: view.center, radius: view.frame.width / 2, view: view)
    }

    convenience init(type: BubbleType, view: UIView) {
        self.init(type: type, isSnapping: true, view: view)
    }

    /// Gets the neighbors of this `BubbleObject`.
    /// - Returns: An array of neighbors if there exists; empty array otherwise.
    func getNeighbors() -> [BubbleObject] {
        var neighbors: [BubbleObject] = []
        for item in attachedWith {
            if let bubble = item as? BubbleObject {
                neighbors.append(bubble)
            }
        }
        return neighbors
    }

    /// Gets the same color neighbors of this `BubbleObject`.
    /// - Returns: An array of same color neighbors if there exists; empty array otherwise.
    func getSameColorNeighbors() -> [BubbleObject] {
        // Bomb bubbles can be seen as the same color as all neighboring bubbles.
        guard type != .bomb else {
            return getNeighbors()
        }
        return getNeighbors().filter { $0.type == type }
    }

    /// Checks whether this bubble is in the same row as the other bubble.
    /// - Parameter bubble: The other bubble to check.
    /// - Returns: true if they are in the same row; false otherwise.
    func isInSameRow(as bubble: BubbleObject) -> Bool {
        return center.y == bubble.center.y
    }

    /// Indicates whether this bubble can touch the top wall directly.
    var canTouchTopWall: Bool {
        return center.y <= radius
    }
}
