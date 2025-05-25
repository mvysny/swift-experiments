//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import XCTest
@testable import SwiftExperiments

final class KotlinKoansTest: XCTestCase {
    func testKoan1() {
        XCTAssertEqual("OK", start())
    }
    func testKoan2() {
        XCTAssertEqual("[a, b, c]", joinOptions(options: ["a", "b", "c"]))
    }
    func testKoan3() {
        XCTAssertEqual(["a42", "b1", "C42", "D2"], useFoo())
    }

    func testKoan5() {
        XCTAssertTrue(try getPattern().matches("13 JUN 1992"))
    }
}
