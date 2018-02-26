//
//  LevelDesignerController+BubbleGrid.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `LevelDesignerController`, which acts as the delegate for `designGrid`.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension LevelDesignerController: UICollectionViewDelegate {

}

/**
 Extension for `LevelDesignerController`, which controls the size of all bubbles
 in the `designerGrid`.
 */
extension LevelDesignerController: UICollectionViewDelegateFlowLayout {
    /// Sets the size of each cell (to fit 11/12 cells per row).
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: FillableBubbleCell.diameter, height: FillableBubbleCell.diameter)
    }

    /// Sets the offset of each row.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRight = (section % 2 == 0) ? 0 : FillableBubbleCell.leftOffset
        let bottom = -FillableBubbleCell.rowOffset
        return UIEdgeInsets(top: 0, left: leftRight, bottom: bottom, right: leftRight)
    }
}

/**
 Extension for `LevelDesignerController`, which acts as the data source for the
 `designerGrid`.
 */
extension LevelDesignerController: UICollectionViewDataSource {
    /// Sets the number of sections (i.e., rows of bubbles).
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return level.numOfRows
    }

    /// Sets the number cells per row (to be different on odd/even row).
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section % 2 == 0) ? level.evenCount : level.oddCount
    }

    /// Data source for each cell.
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = getReusableBubbleCell(for: indexPath)
        let row = indexPath.section
        let column = indexPath.row

        // Fills the cell with the correct color of the bubble.
        if let bubbleType = level.getBubbleAt(row: row, column: column) {
            cell.fill(image: toBubbleImage(of: bubbleType))
        }

        return cell
    }

    /// Gets a reusable cell for preparing a new cell.
    private func getReusableBubbleCell(for indexPath: IndexPath) -> FillableBubbleCell {
        guard let cell = designerGrid.dequeueReusableCell(withReuseIdentifier: Settings.designerCellId,
                                                        for: indexPath) as? FillableBubbleCell else {
                fatalError("Unable to dequeue a reusable cell.")
        }
        cell.clear()
        return cell
    }

    /// Gets an image of the bubble cell according to its type.
    /// - Parameter type: The type of the bubble
    /// - Returns: The background image corresponding to this type.
    private func toBubbleImage(of type: BubbleType) -> UIImage {
        switch type {
        case .blue:
            return #imageLiteral(resourceName: "bubble-blue")
        case .green:
            return #imageLiteral(resourceName: "bubble-green")
        case .orange:
            return #imageLiteral(resourceName: "bubble-orange")
        case .red:
            return #imageLiteral(resourceName: "bubble-red")
        case .indestructible:
            return #imageLiteral(resourceName: "bubble-indestructible")
        case .lightning:
            return #imageLiteral(resourceName: "bubble-lightning")
        case .magnetic:
            return #imageLiteral(resourceName: "bubble-magnetic")
        case .star:
            return #imageLiteral(resourceName: "bubble-star")
        case .bomb:
            return #imageLiteral(resourceName: "bubble-bomb")
        }
    }
}
