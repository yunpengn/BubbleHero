//
//  BubbleType.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import Darwin

/**
 `BubbleType` is an enumeration that defines the type of a bubble. It includes
 some basic color types, like red and green. It also includes some special
 types, like lightning and bomb. Each bubble in the whole game must have one
 and only one `BubbleType`.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
enum BubbleType: Int, Codable {
    case blue
    case green
    case orange
    case red
    case indestructible
    case lightning
    case bomb
    case star
    case magnetic

    /// Cycles the color type of a bubble in the order of blue -> green ->
    /// orange -> red -> blue ...
    /// - Returns: The next type in the cycling of colors if the current type
    /// is a color type; nil otherwise.
    func nextColor() -> BubbleType? {
        switch self {
        case .blue:
            return .green
        case .green:
            return .orange
        case .orange:
            return .red
        case .red:
            return .blue
        default:
            return nil
        }
    }

    /// Returns a pseudo-random type out of all possible `BubbleType`s.
    /// - Returns: The random type got.
    static func getRandomType() -> BubbleType {
        let randomValue = Int(arc4random_uniform(Settings.numOfTypes))
        guard let type = BubbleType(rawValue: randomValue) else {
            fatalError("The numOfTypes setting is wrong.")
        }
        return type
    }

    /// Returns a pseudo-random type out of all basic `BubbleType`s (only including
    /// color types).
    /// - Returns: The random basic type got.
    static func getRandomBasicType() -> BubbleType {
        let randomValue = Int(arc4random_uniform(Settings.numOfBasicTypes))
        guard let type = BubbleType(rawValue: randomValue) else {
            fatalError("The numOfTypes setting is wrong.")
        }
        return type
    }
}
