//
//  UIImage+Slice.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Extension for `UIImage`, which provides some helper methods to slice
 an image (and only returns part of it).

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension UIImage {
    /// Slices an image into (numOfRows, numOfColumns) equal pieces and returns the
    /// piece with a certain index.
    /// - Parameters:
    ///    - index: The index of the intended piece (zero-based).
    ///    - numOfRows: The number of pieces vertically.
    ///    - numOfColumns: The total number of pieces horizontally.
    /// - Returns: the intended piece (with the same size as the original image).
    func slice(index: Int, numOfRows: Int, numOfColumns: Int) -> UIImage? {
        return slice(row: index / numOfColumns,
                     column: index % numOfColumns,
                     numOfRows: numOfRows,
                     numOfColumns: numOfColumns)
    }

    /// Slices an image into (numOfRows, numOfColumns) equal pieces and returns the
    /// piece with index of (row, column).
    /// - Parameters:
    ///    - row: The row number of the intended piece (zero-based).
    ///    - column: The column number of the intended piece (zero-based).
    ///    - numOfRows: The number of pieces vertically.
    ///    - numOfColumns: The total number of pieces horizontally.
    /// - Returns: the intended piece (with the same size as the original image).
    func slice(row: Int, column: Int, numOfRows: Int, numOfColumns: Int) -> UIImage? {
        let unitWidth = size.width / CGFloat(numOfColumns)
        let unitHeight = size.height / CGFloat(numOfRows)
        let area = CGRect(x: unitWidth * CGFloat(column) * scale,
                          y: unitHeight * CGFloat(row) * scale,
                          width: unitWidth * scale,
                          height: unitHeight * scale)
        guard let newCgImage = cgImage?.cropping(to: area) else {
            return nil
        }
        return UIImage(cgImage: newCgImage, scale: scale, orientation: imageOrientation)
    }
}
