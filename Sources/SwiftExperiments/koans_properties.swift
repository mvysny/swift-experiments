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
