//
//  BubbleView.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit
import SpriteKit

/**
 An `UIImageView` designated for bubbles.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class BubbleView: UIImageView {
    /// An array of images used as the explosion animation spritesheet.
    private static let sprite = Array(0..<4).map { index in
        return SKTexture(image: #imageLiteral(resourceName: "bubble-burst").slice(index: index, numOfRows: 1, numOfColumns: 4) ?? #imageLiteral(resourceName: "bubble-indestructible"))
    }
    /// The action for explosion animation.
    private static let action = SKAction.animate(with: BubbleView.sprite,
                                                 timePerFrame: 0.1,
                                                 resize: false,
                                                 restore: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    /// Performs some intial settings.
    private func setup() {
        super.awakeFromNib()
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 4
        removeBorder()
    }

    /// Adds a purple border with a width of 2 around the bubble image.
    func addBorder() {
        layer.borderColor = UIColor.purple.cgColor
    }

    /// Removes the purple border from the bubble image.l
    func removeBorder() {
        layer.borderColor = UIColor.clear.cgColor
    }

    /// Adds explode animation to the bubble view. This method is not thread safe.
    /// - Parameter handler: The handler when the effect has completed.
    func explode(onComplete handler: @escaping () -> Void) {
        let node = SKSpriteNode(texture: BubbleView.sprite[0])
        node.position = center
        node.run(BubbleView.action, completion: handler)
    }
}
