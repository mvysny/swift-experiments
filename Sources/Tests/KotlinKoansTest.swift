//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import XCTest
@testable import SwiftExperiments

final class KotlinKoansTest: XCTestCase {
    func testKoanComparisons() {
        XCTAssertLessThan(MyDate.parse("2024-1-1"), MyDate("2024-1-2"))
        XCTAssertEqual("2024-5-6", "\(MyDate(year: 2024, month: 5, day: 6))")
        XCTAssertTrue(checkInRange(date: MyDate("2025-2-2"), first: MyDate("2025-1-4"), last: MyDate("2026-1-1")))
        XCTAssertEqual(MyDate("2024-1-2"), MyDate("2024-1-1").tomorrow())
        XCTAssertEqual(-1, MyDate("2024-1-2").getDays(to: MyDate("2024-1-1")))
        XCTAssertEqual(MyDate("2024-1-2"), MyDate("2024-1-1").plusDays(1))
        XCTAssertEqual(MyDate("2024-1-6"), MyDate("2024-1-1").plusDays(5))
        XCTAssertEqual(MyDate("2024-1-8"), MyDate("2024-1-1").plusDays(7))
        XCTAssertEqual(MyDate("2026-1-1"), MyDate("2024-1-1").plusYears(2))
    }
    func testKoanRanges() {
        var dates: [MyDate] = Array(MyDate("2024-1-1")...MyDate("2024-1-3"))
        XCTAssertEqual("[2024-1-1, 2024-1-2, 2024-1-3]", dates.description)
        dates = Array(MyDateRange(from: MyDate("2024-1-1"), to: MyDate("2024-1-3")))
        XCTAssertEqual("[2024-1-1, 2024-1-2, 2024-1-3]", dates.description)
    }
    func testKoanForLoops() {
        var dates: [MyDate] = []
        iterateOverDateRange(firstDate: MyDate("2024-1-1"), secondDate: MyDate("2024-1-3")) { dates.append($0) }
        XCTAssertEqual("[2024-1-1, 2024-1-2, 2024-1-3]", dates.description)
    }
    func testKoanOperatorOverloading() {
        XCTAssertEqual(MyDate("2025-1-8"), task1(MyDate("2024-1-1")))
        XCTAssertEqual(MyDate("2026-1-27"), task2(MyDate("2024-1-1")))
    }
}
