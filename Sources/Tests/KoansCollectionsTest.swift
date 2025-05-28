import Testing
import Numerics
@testable import SwiftExperiments

struct KoansCollectionsTest {
    /// https://play.kotlinlang.org/koans/Collections/Sort/Task.kt
    @Test func testSort() {
        #expect(["pasi", "mavi", "kari"] == lidl.getCustomersSortedByOrders().map { $0.name })
    }
    /// https://play.kotlinlang.org/koans/Collections/Filter%20map/Task.kt
    @Test func testFilterMap() {
        #expect([City.Paris, City.Helsinki] == lidl.getCustomerCities())
        #expect(["mavi"] == lidl.getCustomersFrom(city: .Helsinki).map { $0.name })
        #expect(["kari", "pasi"] == lidl.getCustomersFrom(city: .Paris).map { $0.name })
    }
    /// https://play.kotlinlang.org/koans/Collections/All%20Any%20and%20other%20predicates/Task.kt
    @Test func testAllAnyAndOtherPredicates() {
        #expect(!lidl.checkAllCustomersAreFrom(city: .Helsinki))
        #expect(lidl.hasCustomerFrom(city: .Helsinki))
        #expect(1 == lidl.countCustomersFrom(city: .Helsinki))
        #expect(lidl.customers[1] == lidl.findCustomerFrom(city: .Helsinki))
    }

    @Test func testAssociate() {
        #expect(["kari=kari", "mavi=mavi", "pasi=pasi"] == lidl.nameToCustomerMap().map { "\($0.key)=\($0.value.name)" } .sorted())
        #expect(["kari: Paris", "mavi: Helsinki", "pasi: Paris"] == lidl.customerToCityMap().map { "\($0.key.name): \($0.value)" } .sorted())
    }

    /// https://play.kotlinlang.org/koans/Collections/GroupBy/Task.kt
    @Test func testGroupBy() {
        #expect([City.Helsinki : ["mavi"], City.Paris : ["kari", "pasi"]] == lidl.groupCustomersByCity().mapValues { $0.map { $0.name } })
    }

    @Test func testPartition() {
        #expect(["pasi"] == lidl.getCustomersWithMoreUndeliveredOrders().map { $0.name })
    }

    /// https://play.kotlinlang.org/koans/Collections/FlatMap/Task.kt
    @Test func testFlatMap() {
        #expect(["pommes", "miel", "miel"] == lidl.customers.first { $0.name == "mavi" }! .getOrderedProducts().map { $0.name })
        #expect(["pommes", "miel", "pommes", "miel"] == lidl.customers.first { $0.name == "pasi" }! .getOrderedProducts().map { $0.name })
        #expect(["miel", "pommes"] == lidl.getOrderedProducts().map { $0.name } .sorted())
    }
    
    /// https://play.kotlinlang.org/koans/Collections/Max%20min/Task.kt
    @Test func testMaxMin() {
        #expect("pasi" == lidl.getCustomerWithMaxOrders()!.name)
        #expect("miel" == getMostExpensiveProductBy(customer: lidl.customers[2])!.name)
    }

    /// https://play.kotlinlang.org/koans/Collections/Sum/Task.kt
    @Test func testSum() {
        #expect(moneySpentBy(customer: lidl.customers[0]).isApproximatelyEqual(to: 1.2))
        #expect(moneySpentBy(customer: lidl.customers[1]).isApproximatelyEqual(to: 5.6))
        #expect(moneySpentBy(customer: lidl.customers[2]).isApproximatelyEqual(to: 6.8))
    }

    /// https://play.kotlinlang.org/koans/Collections/Fold%20and%20reduce/Task.kt
    @Test func testFoldAndReduce() {
        #expect(["pommes"] == lidl.getProductsOrderedByAll().map { $0.name })
    }
    
    /// https://play.kotlinlang.org/koans/Collections/Compound%20tasks/Task.kt
    @Test func testCompoundTasks() {
        #expect("pommes" == findMostExpensiveProductBy(customer: lidl.customers[0])?.name)
        #expect("miel" == findMostExpensiveProductBy(customer: lidl.customers[1])?.name)
        #expect("pommes" == findMostExpensiveProductBy(customer: lidl.customers[2])?.name)
        
        #expect(lidl.getNumberOfTimesProductWasOrdered(product: pommes) == 4)
        #expect(lidl.getNumberOfTimesProductWasOrdered(product: miel) == 4)
    }
    
    /// https://play.kotlinlang.org/koans/Collections/Getting%20used%20to%20new%20style/Task.kt
    @Test func testGettingUsedToNewStyle() {
        #expect(["a", "a", "b"] == doSomethingWithCollection(collection: ["a", "a", "b", "bb", "cc", "ddd"]))
    }
}
