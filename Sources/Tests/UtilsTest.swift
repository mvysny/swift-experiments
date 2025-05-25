//
//  UtilsTest.swift
//  Swift-Experiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import XCTest
@testable import SwiftExperiments

final class UtilsTest : XCTestCase {
    func testAssociateWith() throws {
        print(["a":1, "aa":2], ["a", "aa"].associateWith { $0.count })
    }
}
