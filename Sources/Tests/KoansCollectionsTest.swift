import XCTest
@testable import SwiftExperiments

final class KoansCollectionsTest: XCTestCase {
    func testSort() {
        XCTAssertEqual(["pasi", "mavi", "kari"], lidl.getCustomersSortedByOrders().map { $0.name })
    }
    func testFilterMap() {
        XCTAssertEqual([City.Paris, City.Helsinki], lidl.getCustomerCities())
        XCTAssertEqual(["mavi"], lidl.getCustomersFrom(city: .Helsinki).map { $0.name })
        XCTAssertEqual(["kari", "pasi"], lidl.getCustomersFrom(city: .Paris).map { $0.name })
    }
}