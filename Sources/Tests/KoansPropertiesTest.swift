//
//  KoansPropertiesTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 26.5.2025.
//


import Testing
@testable import SwiftExperiments

struct KoansPropertiesTest {
    /// https://play.kotlinlang.org/koans/Properties/Properties/Task.kt
    @Test func testProperties() {
        let pe = PropertyExample()
        #expect(pe.propertyWithCounter == nil)
        #expect(pe.counter == 0)
        pe.propertyWithCounter = 2
        #expect(pe.propertyWithCounter == 2)
        #expect(pe.counter == 1)
        pe.propertyWithCounter = 3
        #expect(pe.propertyWithCounter == 3)
        #expect(pe.counter == 2)
    }
    
    /// https://play.kotlinlang.org/koans/Properties/Lazy%20property/Task.kt
    @Test func testLazyProperty() {
        var called = false
        let prop = LazyProperty({ called = true; return 42 })
        #expect(!called)
        let value = prop.lazyValue
        #expect(value == 42)
        #expect(called)
    }
    
    /// https://play.kotlinlang.org/koans/Properties/Delegates%20examples/Task.kt
    @Test func testLazyProperty2() {
        var called = false
        let prop = LazyProperty2({ called = true; return 42 })
        #expect(!called)
        let value = prop.value
        #expect(value == 42)
        #expect(called)
    }
    
    /// https://play.kotlinlang.org/koans/Properties/Delegates%20how%20it%20works/Task.kt
    @Test func testDelegates() throws {
        var d = D()
        #expect(d.date == nil)
        d.date = try MyDate("2025-2-3")
        #expect(d.date == (try MyDate("2025-2-3")))
    }
}
