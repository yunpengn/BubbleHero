//
//  LoadLevelController+Gallery.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `LoadLevelController`, which acts as the delegate for `galleryGrid`.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension LoadLevelController: UICollectionViewDelegate {

}

/**
 Extension for `LoadLevelController`, which controls the size of all cells in `galleryGrid`.
 */
extension LoadLevelController: UICollectionViewDelegateFlowLayout {
    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: LevelGalleryCell.width, height: LevelGalleryCell.height)
    }

    /// Sets the offset of each row.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = LevelGalleryCell.inset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

/**
 Extension for `LoadLevelController`, which is the data source for `galleryGrid` (all
 previously saved levels).
 */
extension LoadLevelController: UICollectionViewDataSource {
    /// Sets the number of cells.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelGallery.numOfLevels
    }

    /// Data source for each cell.
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Settings.galleryCellId,
                                                            for: indexPath) as? LevelGalleryCell else {
            fatalError("Unable to dequeue a reusable cell.")
        }

        let index = indexPath.row
        let imagePath = levelGallery.getImagePath(at: index)
        guard let levelImage = UIImage(contentsOfFile: imagePath.path) else {
            fatalError("Cannot retrieve the image")
        }
        cell.image.image = levelImage

        let dataPath = levelGallery.getDataPath(at: index)
        cell.name.text = dataPath.deletingPathExtension().lastPathComponent

        return cell
    }
}
