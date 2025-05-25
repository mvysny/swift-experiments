// https://play.kotlinlang.org/koans/Collections/Introduction/Task.kt
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
        Order(products: [Product(name: "miel", price: 2.2)], isDelivered: false),
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

// Collections: Partition
extension Shop {
    func getCustomersWithMoreUndeliveredOrders() -> Set<Customer> {
        customers.filter {
            var orders = $0.orders
            let pr: Int = orders.partition { $0.isDelivered }
            return pr > orders.count / 2
        } .toSet()
    }
}

// Collections: FlatMap
extension Customer {
    /// Return all products the given customer has ordered
    func getOrderedProducts() -> [Product] {
        orders.flatMap { $0.products }
    }
}
extension Shop {
    /// Return all products that were ordered by at least one customer
    func getOrderedProducts() -> Set<Product> {
        customers.flatMap { $0.getOrderedProducts() } .toSet()
    }
}

// Collections: Max min
/// Return a customer who has placed the maximum amount of orders

extension Shop {
    func getCustomerWithMaxOrders() -> Customer? {
        customers.max { $0.orders.count < $1.orders.count }
    }
}

/// Return the most expensive product that has been ordered by the given customer
func getMostExpensiveProductBy(customer: Customer) -> Product? {
    customer.getOrderedProducts().maxByOrNull { $0.price }
}

// todo more: https://play.kotlinlang.org/koans/Collections/Sum/Task.kt
