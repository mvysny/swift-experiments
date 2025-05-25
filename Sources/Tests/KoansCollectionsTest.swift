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

    func testAssociate() {
        XCTAssertEqual(["kari=kari", "mavi=mavi", "pasi=pasi"], lidl.nameToCustomerMap().map { "\($0.key)=\($0.value.name)" } .sorted())
        XCTAssertEqual(["kari: Paris", "mavi: Helsinki", "pasi: Paris"], lidl.customerToCityMap().map { "\($0.key.name): \($0.value)" } .sorted())
    }

    /// https://play.kotlinlang.org/koans/Collections/GroupBy/Task.kt
    func testGroupBy() {
        XCTAssertEqual([City.Helsinki : ["mavi"], City.Paris : ["kari", "pasi"]], lidl.groupCustomersByCity().mapValues { $0.map { $0.name } })
    }

    func testPartition() {
        XCTAssertEqual(["pasi"], lidl.getCustomersWithMoreUndeliveredOrders().map { $0.name })
    }

    /// https://play.kotlinlang.org/koans/Collections/FlatMap/Task.kt
    func testFlatMap() {
        XCTAssertEqual(["pommes", "miel", "miel"], lidl.customers.first { $0.name == "mavi" }! .getOrderedProducts().map { $0.name })
        XCTAssertEqual(["pommes", "miel", "pommes", "miel"], lidl.customers.first { $0.name == "pasi" }! .getOrderedProducts().map { $0.name })
        XCTAssertEqual(["miel", "pommes"], lidl.getOrderedProducts().map { $0.name } .sorted())
    }
    
    /// https://play.kotlinlang.org/koans/Collections/Max%20min/Task.kt
    func testMaxMin() {
        XCTAssertEqual("pasi", lidl.getCustomerWithMaxOrders()!.name)
        XCTAssertEqual("miel", getMostExpensiveProductBy(customer: lidl.customers[2])!.name)
    }
}
