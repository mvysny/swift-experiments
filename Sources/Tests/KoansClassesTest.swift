//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import XCTest
@testable import SwiftExperiments

final class KoansClassesTest: XCTestCase {
    func testKoanDataClasses() {
        print(getPeople())
        XCTAssertTrue(comparePeople())
        XCTAssertFalse(comparePeople2())
    }
    func testKoanSmartCasts() {
        XCTAssertEqual(3, eval(Num(value: 3)))
        XCTAssertEqual(3, eval(Sum(left: Num(value: 2), right: Num(value: 1))))
    }
    func testKoanExtensionFunctions() {
        XCTAssertEqual(1.0, 1.r().doubleValue)
        XCTAssertEqual("1/1", "\(1.r())")
    }
}
