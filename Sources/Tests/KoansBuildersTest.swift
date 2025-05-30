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
    
    @Test func testBuildMap() {
        #expect(usage() == (0...10).associate(with: { "\($0)" } ))
    }
}
