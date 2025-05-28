//
//  koans_properties.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 26.5.2025.
//

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
    let initializer: () -> Int
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
