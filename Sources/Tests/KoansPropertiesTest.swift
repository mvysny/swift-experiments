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
        let value = LazyProperty({ 42 }).lazyValue
        XCTAssertEqual(42, value)
    }
}
