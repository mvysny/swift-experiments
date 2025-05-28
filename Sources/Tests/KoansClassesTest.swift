//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import Testing
@testable import SwiftExperiments

struct KoansClassesTest {
    @Test func testKoanDataClasses() {
        print(getPeople())
        #expect(comparePeople())
        #expect(!comparePeople2())
    }
    @Test func testKoanSmartCasts() {
        #expect(3 == eval(Num(value: 3)))
        #expect(3 == eval(Sum(left: Num(value: 2), right: Num(value: 1))))
    }
    @Test func testKoanExtensionFunctions() {
        #expect(1.r().doubleValue == 1.0)
        #expect("1/1" == "\(1.r())")
    }
}
