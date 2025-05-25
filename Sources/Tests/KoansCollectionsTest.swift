import XCTest
@testable import SwiftExperiments

final class KoansCollectionsTest: XCTestCase {
    /// https://play.kotlinlang.org/koans/Collections/Sort/Task.kt
    func testSort() {
        XCTAssertEqual(["pasi", "mavi", "kari"], lidl.getCustomersSortedByOrders().map { $0.name })
    }
    /// https://play.kotlinlang.org/koans/Collections/Filter%20map/Task.kt
    func testFilterMap() {
        XCTAssertEqual([City.Paris, City.Helsinki], lidl.getCustomerCities())
        XCTAssertEqual(["mavi"], lidl.getCustomersFrom(city: .Helsinki).map { $0.name })
        XCTAssertEqual(["kari", "pasi"], lidl.getCustomersFrom(city: .Paris).map { $0.name })
    }
    /// https://play.kotlinlang.org/koans/Collections/All%20Any%20and%20other%20predicates/Task.kt
    func testAllAnyAndOtherPredicates() {
        XCTAssertFalse(lidl.checkAllCustomersAreFrom(city: .Helsinki))
        XCTAssertTrue(lidl.hasCustomerFrom(city: .Helsinki))
        XCTAssertEqual(1, lidl.countCustomersFrom(city: .Helsinki))
        XCTAssertEqual(lidl.customers[1], lidl.findCustomerFrom(city: .Helsinki))
    }

    /// https://play.kotlinlang.org/koans/Collections/GroupBy/Task.kt
    func testGroupBy() {
        XCTAssertEqual([City.Helsinki : ["mavi"], City.Paris : ["kari", "pasi"]], lidl.groupCustomersByCity().mapValues { $0.map { $0.name } })
    }
}