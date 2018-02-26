//
//  BubbleTypeTests.swift
//  BubbleHeroTests
//
//  Created by Yunpeng Niu on 26/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import XCTest
@testable import BubbleHero

class BubbleTypeTests: XCTestCase {
    func testNextColor() {
        XCTAssertEqual(BubbleType.blue.nextColor(), BubbleType.green, "The next color of blue is wrong")
        XCTAssertEqual(BubbleType.green.nextColor(), BubbleType.orange, "The next color of green is wrong")
        XCTAssertEqual(BubbleType.orange.nextColor(), BubbleType.red, "The next color of orange is wrong")
        XCTAssertEqual(BubbleType.red.nextColor(), BubbleType.blue, "The next color of red is wrong")
    }
}
