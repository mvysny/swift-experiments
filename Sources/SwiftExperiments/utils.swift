//
//  utils.swift
//  SwiftExperiments
//
//  Created by Martin Vysny on 25.5.2025.
//

import Foundation

extension Collection where Element: Hashable {
    func toSet() -> Set<Element> {
        if (self is Set<Element>) {
            self as! Set<Element>
        } else {
            Set(self)
        }
    }

    /// Returns a dictionary, mapping elements of this array to the values produced by the `transform` closure.
    ///
    /// In this example, `associateWith` is used first to associate the names in the array
    /// with their lengths.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let map = cast.associateWith { $0.count }
    ///     // 'map' == ["Vivien": 6, "Marlon": 6, "Kim": 3, "Karl: 4"]
    ///
    /// - Parameter transform: Closure which provides values. `transform` accepts an
    ///   element of this sequence as its parameter and returns the values to be put in resulting dictionary.
    /// - Returns: A dictionary, with keys equal to elements of this array
    func associateWith<V>(_ transform: (Element) throws -> V) rethrows -> [Element: V] {
        Dictionary(uniqueKeysWithValues: try self.map { ($0, try transform($0)) })
    }
}

extension Collection {
    func sortedBy<C: Comparable>(_ extractor: (Element) throws -> C) rethrows -> [Element] {
        try sorted { try extractor($0) < (try extractor($1)) }
    }
    
    /// Returns the number of elements in the sequence that satisfy the given
    /// predicate.
    ///
    /// You can use this method to count the number of elements that pass a test.
    /// The following example finds the number of names that are fewer than
    /// five characters long:
    ///
    ///     let names = ["Jacqueline", "Ian", "Amy", "Juan", "Soroush", "Tiffany"]
    ///     let shortNameCount = names.count(where: { $0.count < 5 })
    ///     // shortNameCount == 3
    ///
    /// To find the number of times a specific element appears in the sequence,
    /// use the equal to operator (`==`) in the closure to test for a match.
    ///
    ///     let birds = ["duck", "duck", "duck", "duck", "goose"]
    ///     let duckCount = birds.count(where: { $0 == "duck" })
    ///     // duckCount == 4
    ///
    /// The sequence must be finite.
    ///
    /// - Parameter predicate: A closure that takes each element of the sequence
    ///   as its argument and returns a Boolean value indicating whether
    ///   the element should be included in the count.
    /// - Returns: The number of elements in the sequence that satisfy the given
    ///   predicate.
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        try filter(predicate).count
    }
    
    func groupBy<Key: Hashable>(_ transform: (Element) throws -> Key) rethrows -> [Key: [Element]] {
        try reduce(into: [:]) { result, element in
            let key = try transform(element)
            result[key, default: []].append(element)
        }
    }
    
    func associateBy<K: Hashable>(_ transform: (Element) throws -> K) rethrows -> [K: Element] {
        Dictionary(uniqueKeysWithValues: try self.map { try (transform($0), $0) })
    }
    func associate<K: Hashable, V>(_ transform: (Element) throws -> (K, V)) rethrows -> [K: V] {
        Dictionary(uniqueKeysWithValues: try self.map { try transform($0) })
    }
    
    func maxByOrNull<C: Comparable>(_ extractor: (Element) throws -> C) rethrows -> Element? {
        try max { try extractor($0) < (try extractor($1)) }
    }
}

extension Regex {
    func matches(_ string: String) throws -> Bool {
        try wholeMatch(in: string) != nil
    }
}

extension TimeZone {
    static let gmt: TimeZone = TimeZone(identifier: "GMT")!
}

func TODO() -> Never {
    fatalError("Unimplemented")
}
