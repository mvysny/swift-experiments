//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import Testing
@testable import SwiftExperiments

struct KoansConventionsTest {
    @Test func testKoanComparisons() throws {
        #expect(try MyDate.parse("2024-1-1") < (try MyDate("2024-1-2")))
        #expect("2024-5-6" == "\(MyDate(year: 2024, month: 5, day: 6))")
        #expect(checkInRange(date: try MyDate("2025-2-2"), first: try MyDate("2025-1-4"), last: try MyDate("2026-1-1")))
        #expect(try MyDate("2024-1-2") == (try MyDate("2024-1-1").tomorrow()))
        #expect(try MyDate("2024-1-1") == (try MyDate("2024-1-2").yesterday()))
        #expect(try MyDate("2024-1-2").getDays(to: try MyDate("2024-1-1")) == -1)
        #expect(try MyDate("2024-1-2") == (try MyDate("2024-1-1").plusDays(1)))
        #expect(try MyDate("2024-1-6") == (try MyDate("2024-1-1").plusDays(5)))
        #expect(try MyDate("2024-1-8") == (try MyDate("2024-1-1").plusDays(7)))
        #expect(try MyDate("2026-1-1") == (try MyDate("2024-1-1").plusYears(2)))
    }
    @Test func testKoanRanges() throws {
        var dates: [MyDate] = Array((try MyDate("2024-1-1"))...(try MyDate("2024-1-3")))
        #expect(dates.description == "[2024-1-1, 2024-1-2, 2024-1-3]")
        dates = Array(MyDateRange(from: try MyDate("2024-1-1"), to: try MyDate("2024-1-3")))
        #expect(dates.description == "[2024-1-1, 2024-1-2, 2024-1-3]")
    }
    @Test func testKoanForLoops() throws {
        var dates: [MyDate] = []
        iterateOverDateRange(firstDate: try MyDate("2024-1-1"), secondDate: try MyDate("2024-1-3")) { dates.append($0) }
        #expect(dates.description == "[2024-1-1, 2024-1-2, 2024-1-3]")
    }
    @Test func testKoanOperatorOverloading() throws {
        #expect(task1(try MyDate("2024-1-1")) == (try MyDate("2025-1-8")))
        #expect(try MyDate("2026-1-27") == task2(try MyDate("2024-1-1")))
    }
}
