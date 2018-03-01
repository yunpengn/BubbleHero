//
//  BubbleSource.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Provides random `BubbleType`s continously, i.e., acts as the source for bubble
 launcher and the hint for next bubbles.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
struct BubbleSource {
    /// The number of upcoming bubbles that the source is able to preview,
    /// which works like a buffer zone or gives players a hint.
    private let next: Int
    /// The internal data structure to maintain the upcoming bubble sequence.
    private var bubbles: FixedQueue<BubbleType>
    /// The internal data structure to maintain whether the upcoming bubble
    /// is snapping.
    private var snappings: FixedQueue<Bool>

    /// Creates a new source for bubbles with an allowed number of upcoming
    /// bubbles to preview.
    /// - Parameter next: The allowed number of bubbles to preview.
    init(next: Int) {
        self.next = next
        self.bubbles = FixedQueue(with: Array(0..<next).map { _ in
            BubbleType.getRandomColorType()
        })
        self.snappings = FixedQueue(with: Array(0..<next).map { _ in
            BubbleSource.isSnapping()
        })
    }

    /// Gets the next bubble to launch.
    /// - Returns: a tuple indicating the type of the next bubble and whether
    /// it is snapping.
    mutating func pop() -> (type: BubbleType, isSnapping: Bool) {
        let item = bubbles.pop(byAdd: BubbleType.getRandomColorType())
        let isSnapping = snappings.pop(byAdd: BubbleSource.isSnapping())
        return (item, isSnapping)
    }

    /// Gets the nth next bubble. The bubble that is going to be launched next
    /// has an index of 0.
    /// - Returns: a tuple indicating the type of the  bubble and whether it is
    /// snapping.
    func getBubble(at index: Int) -> (type: BubbleType, isSnapping: Bool)? {
        guard let item = bubbles.getItem(at: index),
            let isSnapping = snappings.getItem(at: index) else {
            return nil
        }
        return (item, isSnapping)
    }

    /// Randomly generats whether a bubble is a snapping bubble.
    /// - Returns: true if the bubble is snapping.
    private static func isSnapping() -> Bool {
        return Double.random < Settings.snappingThreshold
    }
}
