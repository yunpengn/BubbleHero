//
//  FillableBubbleCell.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 A cell for the collection view in level designer view.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class FillableBubbleCell: UICollectionViewCell {
    /// The diameter of each bubble
    static let diameter = UIScreen.main.bounds.width / CGFloat(Settings.cellPerRow)
    /// The radius of each bubble
    static let radius = FillableBubbleCell.diameter / 2
    /// The offset on y-axis for bubbles on odd rows.
    static let leftOffset = FillableBubbleCell.radius
    /// The offset between two succeeding rows.
    static let rowOffset = FillableBubbleCell.radius * (2 - sqrt(3))
    /// The height for each row.
    static let height = FillableBubbleCell.radius * sqrt(3)

    /// The background image of this bubble cell.
    private var background: UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    /// Sets up an empty bubble cell.
    private func setup() {
        contentView.layer.cornerRadius = FillableBubbleCell.radius
        clear()
    }

    /// Removess the background image of the cell and sets it to look like an empty
    /// template bubble.
    func clear() {
        contentView.backgroundColor = UIColor.white
        contentView.alpha = Settings.alphaBubbleCellEmpty
        background?.removeFromSuperview()
        background = nil
    }

    /// Fills the bubble by setting its background image.
    /// - Parameter image: The image that will fill the bubble.
    func fill(image: UIImage) {
        contentView.backgroundColor = nil
        contentView.alpha = Settings.alphaBubbleCellFilled

        // Adds the background image to content view, as recommended in
        // Swift's official documentation.
        background?.removeFromSuperview()
        let imageView = UIImageView(image: image)
        imageView.frame = self.bounds
        contentView.addSubview(imageView)
        background = imageView
    }
}

