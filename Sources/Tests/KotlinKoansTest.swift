//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import XCTest
@testable import SwiftExperiments

final class KotlinKoansTest: XCTestCase {
    func testKoan1() {
        XCTAssertEqual("OK", start())
    }
    func testKoan2() {
        XCTAssertEqual("[a, b, c]", joinOptions(options: ["a", "b", "c"]))
    }
    func testKoan3() {
        XCTAssertEqual(["a42", "b1", "C42", "D2"], useFoo())
    }
    func testKoan4() {
        print(tripleQuotedString)
    }
    func testKoan5() {
        XCTAssertTrue(try getPattern().matches("13 JUN 1992"))
    }
    func testKoan6() {
        let mailer = DummyMailer()
        sendMessageToClient(client: nil, message: nil, mailer: mailer)
        XCTAssertEqual([], mailer.messages)
        sendMessageToClient(client: Client(personalInfo: nil), message: nil, mailer: mailer)
        XCTAssertEqual([], mailer.messages)
        sendMessageToClient(client: Client(personalInfo: PersonalInfo(email: "hi")), message: "foo", mailer: mailer)
        XCTAssertEqual(["From hi: foo"], mailer.messages)
    }
    func testKoan7() {
        checkAge(10)
    }
    func testKoanLambdas() {
        XCTAssertTrue(containsEven([1, 2]))
        XCTAssertFalse(containsEven([1, 3, 5]))
    }
    func testKoanDataClasses() {
        print(getPeople())
        XCTAssertTrue(comparePeople())
        XCTAssertFalse(comparePeople2())
    }
    func testKoanSmartCasts() {
        XCTAssertEqual(3, eval(Num(value: 3)))
        XCTAssertEqual(3, eval(Sum(left: Num(value: 2), right: Num(value: 1))))
    }
    func testKoanExtensionFunctions() {
        XCTAssertEqual(1.0, 1.r().doubleValue)
        XCTAssertEqual("1/1", "\(1.r())")
    }
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
}
