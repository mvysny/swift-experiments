//
//  koans_builders.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 30.5.2025.
//

@resultBuilder
struct ListBuilder {
    typealias Component = [Int]
    typealias Expression = Int
    static func buildBlock(_ elements: [Int]...) -> [Int] {
        elements.flatMap { $0 }
    }
}

func buildList(@ListBuilder content: () -> [Int]) -> [Int] {
    content()
}
func makeList() -> [Int] {
    buildList {
        buildList {
            [7, 8]
        }
        [1, 2, 3]
        [4, 5]
    }
}

/// https://play.kotlinlang.org/koans/Builders/String%20and%20map%20builders/Task.kt
@resultBuilder
struct MapBuilder<K: Hashable, V> {
    typealias Component = Dictionary<K, V>
    typealias Expression = (K, V)
    static func buildBlock(_ elements: Component...) -> Component {
        var result: Component = [:]
        for element in elements {
            result.merge(element) { (_, new) in new }
        }
        return result
    }
    static func buildArray(_ components: [Component]) -> Component {
        var result: Component = [:]
        for element in components {
            result.merge(element) { (_, new) in new }
        }
        return result
    }
}

func buildMap(@MapBuilder<Int, String> content: () -> [Int:String]) -> [Int:String] {
    content()
}
func put(_ key: Int, _ value: String) -> [Int:String] {
    [key: value]
}

func usage() -> [Int:String] {
    buildMap {
        put(0, "0")
        for i in 1...10 {
            put(i, "\(i)")
        }
    }
}
