//
//  UtilsTest.swift
//  Swift-Experiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import XCTest
@testable import SwiftExperiments

final class UtilsTest : XCTestCase {
    func testAssociateWith() throws {
        XCTAssertEqual(["a":1, "aa":2], ["a", "aa"].associate(with: { $0.count }))
    }
    func testAssociate() {
        XCTAssertEqual(["A":1, "AA":2], ["a", "aa"].associate { ($0.uppercased(), $0.count) })
    }
    func testAssociateBy() {
        XCTAssertEqual([1:"a", 2:"aa"], ["a", "aa"].associate(by: { $0.count }))
    }
    func testRegexMatches() throws {
        XCTAssertTrue(try #/aaa/#.matches("aaa"))
        XCTAssertFalse(try #/aaa/#.matches("aaaa"))
    }
    func testSortedBy() {
        XCTAssertEqual(["z", "aa", "ddd", "bbbb"], ["aa", "bbbb", "ddd", "z"].sorted(by: { $0.count }))
    }
    func testMaxBy() {
        XCTAssertEqual("bbbb", ["aa", "bbbb", "ddd", "z"].max(by: { $0.count }))
    }
    func testSumInt() {
        XCTAssertEqual(0, [Int]().sum())
        XCTAssertEqual(6, [1, 2, 3].sum())
    }
    func testSumDouble() {
        XCTAssertEqual(0.0, [Double]().sum())
        XCTAssertEqual(6.0, [1.0, 2,0, 3.0].sum())
    }
    func testSumOfInt() {
        XCTAssertEqual(10, ["aa", "bbbb", "ddd", "z"].sum(of: { $0.count }))
    }
    func testSumOfDouble() {
        XCTAssertEqual(10.0, ["aa", "bbbb", "ddd", "z"].sum(of: { Double($0.count) }))
    }
}
