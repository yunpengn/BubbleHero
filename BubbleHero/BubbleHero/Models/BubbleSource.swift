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
    /// Tht total number of bubbles that the source will be able to provide,
    /// after which the source will be considered exhausted and will not
    /// produce new bubbles any more.
    private let total: Int
    /// The number of upcoming bubbles that the source is able to preview,
    /// which works like a buffer zone or gives players a hint.
    private let next: Int
    private var current = BubbleType.getRandomType()

    init(total: Int, next: Int) {
        self.total = total
        self.next = next
    }

    func peek() -> BubbleType {
        return current
    }

    mutating func pop() -> BubbleType {
        current = BubbleType.getRandomType()
        return current
    }
}
