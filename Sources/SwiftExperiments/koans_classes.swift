// Koan: Data classes
struct Person : Equatable {
    let name: String
    let age: Int
}
func getPeople() -> [Person] {
    [Person(name: "Alice", age: 29), Person(name: "Bob", age: 31)]
}

func comparePeople() -> Bool {
    let p1 = Person(name: "Alice", age: 29)
    let p2 = Person(name: "Alice", age: 29)
    return p1 == p2  // should be true
}
func comparePeople2() -> Bool {
    let p1 = Person(name: "Alice", age: 29)
    let p2 = Person(name: "Bob", age: 29)
    return p1 == p2  // should be false
}

// Koan: Smart casts
func eval(_ expr: Expr) -> Int {
    if let num = expr as? Num {
        num.value
    } else if let sum = expr as? Sum {
        eval(sum.left) + eval(sum.right)
    } else {
        fatalError("Unknown expression")
    }
}

protocol Expr {}
struct Num : Expr {
    let value: Int
}
struct Sum : Expr {
    let left: Expr
    let right: Expr
}

// Koan: Extension functions
struct RationalNumber : Equatable, CustomStringConvertible, Comparable {
    let numerator: Int
    let denominator: Int

    var doubleValue: Double {
        Double(numerator) / Double(denominator)
    }

    static func == (lhs: RationalNumber, rhs: RationalNumber) -> Bool {
        lhs.doubleValue == rhs.doubleValue
    }
    static func < (lhs: RationalNumber, rhs: RationalNumber) -> Bool {
        lhs.doubleValue < rhs.doubleValue
    }

    var description: String { "\(numerator)/\(denominator)" }
}
extension Int {
    func r() -> RationalNumber {
        RationalNumber(numerator: self, denominator: 1)
    }
}
