//
//  KoansPropertiesTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 26.5.2025.
//


import Testing
@testable import SwiftExperiments

struct KoansBuildersTest {
    @Test func testBuildList() throws {
        #expect(makeList() == [7, 8, 1, 2, 3, 4, 5])
    }

    /// https://play.kotlinlang.org/koans/Builders/String%20and%20map%20builders/Task.kt
    @Test func testBuildMap() {
        #expect(usage() == (0...10).associate(with: { "\($0)" } ))
    }
    
    /// https://play.kotlinlang.org/koans/Builders/Html%20builders/Task.kt
    @Test func testHtmlBuilders() {
        #expect(makeHtml() == "<html><table><tr><td>Product</td><td>Price</td><td>Popularity</td></tr><tr><td>Product 1</td><td>100 won</td><td>10%</td></tr><tr><td>Product 2</td><td>200 won</td><td>20%</td></tr></table></html>")
    }
}
