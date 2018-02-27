//
//  LevelGalleryCell.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 A cell for the collection view of level gallery.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class LevelGalleryCell: UICollectionViewCell {
    /// The inset for each cell
    static let inset = Settings.levelGalleryCellInset
    /// The width of each cell
    static let width = UIScreen.main.bounds.width / Settings.levelPerRow - LevelGalleryCell.inset * 2
    /// The height of each cell
    static let height = LevelGalleryCell.width + LevelGalleryCell.inset * 1.5

    /// The image shown in this cell (to preview the level).
    @IBOutlet weak var image: UIImageView!
    /// The name shown below the image.
    @IBOutlet weak var name: UILabel!
}
