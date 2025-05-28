//
//  KoansPropertiesTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 26.5.2025.
//


import XCTest
@testable import SwiftExperiments

final class KoansPropertiesTest: XCTestCase {
    /// https://play.kotlinlang.org/koans/Properties/Properties/Task.kt
    func testProperties() {
        let pe = PropertyExample()
        XCTAssertEqual(nil, pe.propertyWithCounter)
        XCTAssertEqual(0, pe.counter)
        pe.propertyWithCounter = 2
        XCTAssertEqual(2, pe.propertyWithCounter)
        XCTAssertEqual(1, pe.counter)
        pe.propertyWithCounter = 3
        XCTAssertEqual(3, pe.propertyWithCounter)
        XCTAssertEqual(2, pe.counter)
    }
    
    /// https://play.kotlinlang.org/koans/Properties/Lazy%20property/Task.kt
    func testLazyProperty() {
        var called = false
        let prop = LazyProperty({ called = true; return 42 })
        XCTAssertFalse(called)
        let value = prop.lazyValue
        XCTAssertEqual(42, value)
        XCTAssertTrue(called)
    }
    
    /// https://play.kotlinlang.org/koans/Properties/Delegates%20examples/Task.kt
    func testLazyProperty2() {
        var called = false
        let prop = LazyProperty2({ called = true; return 42 })
        XCTAssertFalse(called)
        let value = prop.value
        XCTAssertEqual(42, value)
        XCTAssertTrue(called)
    }
    
    /// https://play.kotlinlang.org/koans/Properties/Delegates%20how%20it%20works/Task.kt
    func testDelegates() throws {
        var d = D()
        XCTAssertNil(d.date)
        d.date = try MyDate("2025-2-3")
        XCTAssertEqual(try MyDate("2025-2-3"), d.date)
    }
}
