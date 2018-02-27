//
//  BubbleSource.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Provides random `BubbleType`s continously, i.e., acts as the source for bubble
 launcher and the hint for next bubble.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
struct BubbleSource {
    private var current = BubbleType.getRandomType()

    func peek() -> BubbleType {
        return current
    }

    mutating func pop() -> BubbleType {
        current = BubbleType.getRandomType()
        return current
    }
}
