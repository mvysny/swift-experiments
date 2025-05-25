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
        expect([], mailer.messages)
        sendMessageToClient(client: Client(personalInfo: nil), message: nil, mailer: mailer)
        expect([], mailer.messages)
        sendMessageToClient(client: Client(personalInfo: PersonalInfo(email: "hi")), message: "foo", mailer: mailer)
        expect(["From hi: foo"], mailer.messages)
    }
}
