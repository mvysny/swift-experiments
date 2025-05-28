//
//  koans_properties.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 26.5.2025.
//

import Foundation

// Properties
// https://play.kotlinlang.org/koans/Properties/Properties/Task.kt

class PropertyExample {
    var counter = 0
    var propertyWithCounter: Int? = nil {
        didSet {
            counter += 1
        }
    }
}

// https://play.kotlinlang.org/koans/Properties/Lazy%20property/Task.kt
class LazyProperty {
    private let initializer: () -> Int
    init(_ initializer: @escaping () -> Int) {
        self.initializer = initializer
    }
    
    private var value: Int? = nil
    var lazyValue: Int {
        get {
            if (value == nil) {
                value = initializer()
            }
            return value!
        }
    }
}

// https://play.kotlinlang.org/koans/Properties/Delegates%20examples/Task.kt
class LazyProperty2 {
    private let initializer: () -> Int
    init(_ initializer: @escaping () -> Int) {
        self.initializer = initializer
    }

    lazy var value: Int = initializer()
}

// https://play.kotlinlang.org/koans/Properties/Delegates%20how%20it%20works/Task.kt
@propertyWrapper
struct EffectiveDate {
    var timeInMillis: Foundation.TimeInterval? = nil
    var wrappedValue: MyDate? {
        get {
            guard let time = timeInMillis else { return nil }
            return MyDate(Date(timeIntervalSince1970: time))
        }
        set {
            timeInMillis = newValue?.atStartOfDayUTC().timeIntervalSince1970
        }
    }
}

struct D {
    @EffectiveDate var date: MyDate?
}
