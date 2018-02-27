//
//  Helpers.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Defines some generic useful helper methods for the application.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class Helpers {
    /// Gets an image of the bubble cell according to its type.
    /// - Parameter type: The type of the bubble
    /// - Returns: The background image corresponding to this type.
    static func toBubbleImage(of type: BubbleType) -> UIImage {
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
