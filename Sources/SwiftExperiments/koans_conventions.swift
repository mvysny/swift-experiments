// https://play.kotlinlang.org/koans/Conventions/Comparison/Task.kt
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
    
    static func parse(_ input: String) throws -> MyDate {
        try MyDate(input)
    }

    func atStartOfDayUTC() -> Date {
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
    
    func yesterday() -> MyDate {
        plusDays(-1)
    }
    
    func plusDays(_ days: Int) -> MyDate {
        guard days != 0 else { return self }
        let date = atStartOfDayUTC()
        let c = Calendar.current
        let nextDate = c.date(byAdding: Calendar.Component.day, value: days, to: date)!
        return MyDate(nextDate)
    }
    
    func plusWeeks(_ weeks: Int) -> MyDate {
        plusDays(weeks * 7)
    }
    
    func plusYears(_ years: Int) -> MyDate {
        guard years != 0 else { return self }
        let date = atStartOfDayUTC()
        let c = Calendar.current
        let nextDate = c.date(byAdding: Calendar.Component.year, value: years, to: date)!
        return MyDate(nextDate)
    }
    
    func getDays(to other: MyDate) -> Int {
        let date1 = atStartOfDayUTC()
        let date2 = other.atStartOfDayUTC()
        let components = Calendar.current.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
}

enum DateParsingError : Error {
    case unparsableDate(_ str: String)
}

extension MyDate {
    init(_ str: String) throws {
        let components = str.split(separator: "-")
        guard components.count == 3, let year = Int(components[0]),
              let month = Int(components[1]),
              let day = Int(components[2]) else {
            throw DateParsingError.unparsableDate(str)
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
