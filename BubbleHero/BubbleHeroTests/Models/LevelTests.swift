//
//  LevelTests.swift
//  BubbleHeroTests
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import XCTest
@testable import BubbleHero

class LevelTests: XCTestCase {
    func testInit() {
        let level = Level()
        XCTAssertEqual(level.numOfRows, Settings.numOfRows, "The number of rows is wrong.")
        XCTAssertEqual(level.evenCount, Settings.cellPerRow, "The even count is wrong.")
        XCTAssertEqual(level.oddCount, Settings.cellPerRow - 1, "The odd count is wrong.")
    }

    func testAddOrUpdateBubble() {
        let level = Level()
        level.addOrUpdateBubble(BubbleType.blue, row: 0, column: 0)
        XCTAssertEqual(level.getBubbleAt(row: 0, column: 0), BubbleType.blue,
                       "The bubble is not inserted correctly.")

        level.addOrUpdateBubble(BubbleType.green, row: 0, column: 0)
        XCTAssertEqual(level.getBubbleAt(row: 0, column: 0), BubbleType.green,
                       "The bubble is not updated correctly.")
    }

    func testHasBubble() {
        let level = Level()
        level.addOrUpdateBubble(BubbleType.blue, row: 0, column: 0)
        XCTAssertTrue(level.hasBubbleAt(row: 0, column: 0),
                      "hasBubble returns the wrong result.")
        XCTAssertFalse(level.hasBubbleAt(row: 0, column: 1),
                       "hasBubble returns the wrong result.")
    }

    func testGetBubbleAt() {
        let level = Level()
        level.addOrUpdateBubble(BubbleType.blue, row: 0, column: 0)
        XCTAssertEqual(level.getBubbleAt(row: 0, column: 0), BubbleType.blue,
                       "getBubbleAt is wrong.")
    }

    func testDeleteBubble() {
        let level = Level()
        level.addOrUpdateBubble(BubbleType.blue, row: 0, column: 0)
        XCTAssertTrue(level.hasBubbleAt(row: 0, column: 0), "The bubble is not inserted correctly.")
        level.deleteBubbleAt(row: 0, column: 1)
        XCTAssertTrue(level.hasBubbleAt(row: 0, column: 0), "deleteBubble is wrong.")
        level.deleteBubbleAt(row: 0, column: 0)
        XCTAssertFalse(level.hasBubbleAt(row: 0, column: 0), "deleteBubble is wrong.")

        level.addOrUpdateBubble(BubbleType.blue, row: 1, column: 1)
        XCTAssertTrue(level.hasBubbleAt(row: 1, column: 1), "The bubble is not inserted correctly.")
        level.deleteBubbleAt(row: 1, column: 1)
        XCTAssertFalse(level.hasBubbleAt(row: 1, column: 1), "deleteBubble is wrong.")
    }
}
