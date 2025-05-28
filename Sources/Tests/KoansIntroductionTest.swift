//
//  KotlinKoansTest.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import Testing
@testable import SwiftExperiments

struct KoansIntroductionTest {
    @Test func testKoan1() {
        #expect(start() == "OK")
    }
    @Test func testKoan2() {
        #expect(joinOptions(options: ["a", "b", "c"]) == "[a, b, c]")
    }
    @Test func testKoan3() {
        #expect(useFoo() == ["a42", "b1", "C42", "D2"])
    }
    @Test func testKoan4() {
        print(tripleQuotedString)
    }
    @Test func testKoan5() throws {
        #expect(try getPattern().matches("13 JUN 1992"))
    }
    @Test func testKoan6() {
        let mailer = DummyMailer()
        sendMessageToClient(client: nil, message: nil, mailer: mailer)
        #expect(mailer.messages == [])
        sendMessageToClient(client: Client(personalInfo: nil), message: nil, mailer: mailer)
        #expect(mailer.messages == [])
        sendMessageToClient(client: Client(personalInfo: PersonalInfo(email: "hi")), message: "foo", mailer: mailer)
        #expect(mailer.messages == ["From hi: foo"])
    }
    @Test func testKoan7() {
        checkAge(10)
    }
    @Test func testKoanLambdas() {
        #expect(containsEven([1, 2]))
        #expect(!containsEven([1, 3, 5]))
    }
    @Test func testKoanDataClasses() {
        print(getPeople())
        #expect(comparePeople())
        #expect(!comparePeople2())
    }
}
