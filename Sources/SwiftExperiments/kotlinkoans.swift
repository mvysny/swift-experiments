//
//  kotlinkoans.swift
//  mavi-testapp
//
//  Created by Martin Vysny on 22.5.2025.
//

import Foundation

// Koan: Comparison
struct MyDate : CustomStringConvertible, Comparable {
    let year: Int
    let month: Int
    let day: Int
    
    var description: String { "\(year)-\(month)-\(day)" }
    
    static func < (lhs: MyDate, rhs: MyDate) -> Bool {
        if (lhs.year != rhs.year) {
            return lhs.year < rhs.year
        } else if (lhs.month != rhs.month) {
            return lhs.month < rhs.month
        } else {
            return lhs.day < rhs.day
        }
    }
    
    static func parse(_ input: String) -> MyDate {
        MyDate(input)
    }
    
    private func toDate() -> Date {
        let c = Calendar.current
        let dateComponents = DateComponents(
            calendar: c, timeZone: TimeZone.gmt,
            year: year, month: month, day: day,
            hour: 0, minute: 0, second: 0
        )
        return c.date(from: dateComponents)!
    }
    
    func tomorrow() -> MyDate {
        plusDays(1)
    }
    
    func plusDays(_ days: Int) -> MyDate {
        guard days != 0 else { return self }
        let date = toDate()
        let c = Calendar.current
        let nextDate = c.date(byAdding: Calendar.Component.day, value: days, to: date)!
        return MyDate(nextDate)
    }
    
    func plusWeeks(_ weeks: Int) -> MyDate {
        plusDays(weeks * 7)
    }
    
    func plusYears(_ years: Int) -> MyDate {
        guard years != 0 else { return self }
        let date = toDate()
        let c = Calendar.current
        let nextDate = c.date(byAdding: Calendar.Component.year, value: years, to: date)!
        return MyDate(nextDate)
    }
    
    func getDays(to other: MyDate) -> Int {
        let date1 = toDate()
        let date2 = other.toDate()
        let components = Calendar.current.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
}

extension MyDate {
    init(_ str: String) {
        let components = str.split(separator: "-")
        guard components.count == 3, let year = Int(String(components[0])),
              let month = Int(String(components[1])),
              let day = Int(String(components[2])) else {
            fatalError("Unparsable date: \(str)")
        }
        self.year = year
        self.month = month
        self.day = day
    }
    init(_ date: Date) {
        let c = Calendar.current
        let components = c.dateComponents(in: TimeZone.gmt, from: date)
        self.year = components.year!
        self.month = components.month!
        self.day = components.day!
    }
}

// Koan: Ranges
func checkInRange(date: MyDate, first: MyDate, last: MyDate) -> Bool {
    first...last ~= date
}

// Koan: For Loop
extension MyDate : Strideable {
    func distance(to other: MyDate) -> Int {
        getDays(to: other)
    }
    
    func advanced(by n: Int) -> MyDate {
        plusDays(n)
    }
}
struct MyDateRange : Equatable, Sequence {
    let from: MyDate
    let to: MyDate
    func makeIterator() -> MyDateIterator {
        MyDateIterator(from: from, to: to)
    }
}

class MyDateIterator : IteratorProtocol {
    private var current: MyDate
    private let to: MyDate
    init(from: MyDate, to: MyDate) {
        self.current = from
        self.to = to
    }
    func next() -> MyDate? {
        if current <= to {
            let result = current
            current = current.tomorrow()
            return result
        }
        return nil
    }
}

func iterateOverDateRange(firstDate: MyDate, secondDate: MyDate, handler: (MyDate) -> Void) {
    for date in firstDate...secondDate {
        handler(date)
    }
}

// Koan: Operators overloading
struct DurationDays {
    let days: Int
    let years: Int

    static func * (left: DurationDays, right: Int) -> DurationDays {
        DurationDays(days: left.days * right, years: left.years * right)
    }
}

enum TimeInterval {
    case DAY, WEEK, YEAR
    
    func duration() -> DurationDays {
        switch self {
        case .DAY: DurationDays(days: 1, years: 0)
        case .WEEK: DurationDays(days: 7, years: 0)
        case .YEAR: DurationDays(days: 0, years: 1)
        }
    }
    
    static func * (left: TimeInterval, right: Int) -> DurationDays {
        left.duration() * right
    }
}
extension MyDate {
    static func + (left: MyDate, right: DurationDays) -> MyDate {
        left.plusDays(right.days).plusYears(right.years)
    }
    static func + (left: MyDate, right: TimeInterval) -> MyDate {
        left + right.duration()
    }
}
func task1(_ today: MyDate) -> MyDate {
    today + TimeInterval.YEAR + TimeInterval.WEEK
}
func task2(_ today: MyDate) -> MyDate {
    today + TimeInterval.YEAR * 2 + TimeInterval.WEEK * 3 + TimeInterval.DAY * 5
}

// # Collections
// Collections: Introduction

struct City : CustomStringConvertible, Hashable {
    let name: String
    var description: String { name }
    
    static let Paris: City = .init(name: "Paris")
    static let Helsinki: City = .init(name: "Helsinki")
}
struct Customer : Hashable {
    let name: String
    let city: City
    let orders: [Order]
}
struct Product : Hashable, CustomStringConvertible {
    let name: String
    let price: Double
    var description: String { "'\(name)' for \(price)" }
}
struct Order : Hashable {
    let products: [Product]
    let isDelivered: Bool
}
struct Shop {
    let name: String
    let customers: [Customer]
}
extension Shop {
    func getSetOfCustomers() -> Set<Customer> {
        Set(customers)
    }
}

let lidl = Shop(name: "LIDL", customers: [
    Customer(name: "kari", city: City.Paris, orders: []),
    Customer(name: "mavi", city: City.Helsinki, orders: [
        Order(products: [Product(name: "pommes", price: 1.2), Product(name: "miel", price: 2.2)], isDelivered: true),
        Order(products: [Product(name: "miel", price: 2.2)], isDelivered: false),
    ]),
    Customer(name: "pasi", city: City.Paris, orders: [
        Order(products: [Product(name: "pommes", price: 1.2)], isDelivered: true),
        Order(products: [Product(name: "miel", price: 2.2)], isDelivered: true),
        Order(products: [Product(name: "pommes", price: 1.2), Product(name: "miel", price: 2.2)], isDelivered: false),
    ]),
])

// Collections: Sort
extension Shop {
    func getCustomersSortedByOrders() -> [Customer] {
        customers.sortedBy { -$0.orders.count }
    }
}

// Collections: Filter map
extension Shop {
    func getCustomerCities() -> Set<City> {
        customers.map { $0.city } .toSet()
    }
    func getCustomersFrom(city: City) -> [Customer] {
        customers.filter { $0.city == city }
    }
}

// Collections: All Any and other predicates
extension Shop {
    func checkAllCustomersAreFrom(city: City) -> Bool {
        customers.allSatisfy { $0.city == city }
    }
    func hasCustomerFrom(city: City) -> Bool {
        customers.contains { $0.city == city }
    }
    func countCustomersFrom(city: City) -> Int {
        customers.count { $0.city == city }
    }
    func findCustomerFrom(city: City) -> Customer? {
        customers.first { $0.city == city }
    }
}

// Collections: Associate
extension Shop {
    func nameToCustomerMap() -> [String: Customer] {
        customers.associateBy { $0.name }
    }
    func customerToCityMap() -> [Customer: City] {
        customers.associateWith { $0.city }
    }
    func customerNameToCityMap() -> [String: City] {
        customers.associate { ($0.name, $0.city) }
    }
}

// Collections: GroupBy
extension Shop {
    func groupCustomersByCity() -> [City: [Customer]] {
        customers.groupBy { $0.city }
    }
}

// todo more: https://play.kotlinlang.org/koans/Collections/Partition/Task.kt
