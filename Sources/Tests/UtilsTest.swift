//
//  UtilsTest.swift
//  Swift-Experiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import Testing
@testable import SwiftExperiments

struct UtilsTest {
    @Test func testAssociateWith() throws {
        #expect(["a":1, "aa":2] == ["a", "aa"].associate(with: { $0.count }))
    }
    @Test func testAssociate() {
        #expect(["A":1, "AA":2] == ["a", "aa"].associate { ($0.uppercased(), $0.count) })
    }
    @Test func testAssociateBy() {
        #expect([1:"a", 2:"aa"] == ["a", "aa"].associate(by: { $0.count }))
    }
    @Test func testRegexMatches() throws {
        #expect(try #/aaa/#.matches("aaa"))
        #expect(try !#/aaa/#.matches("aaaa"))
    }
    @Test func testSortedBy() {
        #expect(["z", "aa", "ddd", "bbbb"] == ["aa", "bbbb", "ddd", "z"].sorted(by: { $0.count }))
    }
    @Test func testMaxBy() {
        #expect("bbbb" == ["aa", "bbbb", "ddd", "z"].max(by: { $0.count }))
    }
    struct Sum {
        @Test func sumInt() {
            #expect(0 == [Int]().sum())
            #expect(6 == [1, 2, 3].sum())
        }
        @Test func sumDouble() {
            #expect(0.0 == [Double]().sum())
            #expect(6.0 == [1.0, 2,0, 3.0].sum())
        }
        @Test func sumOfInt() {
            #expect(10 == ["aa", "bbbb", "ddd", "z"].sum(of: { $0.count }))
        }
        @Test func sumOfDouble() {
            #expect(10.0 == ["aa", "bbbb", "ddd", "z"].sum(of: { Double($0.count) }))
        }
    }
}
