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
    func associate<V>(with transform: (Element) throws -> V) rethrows -> [Element: V] {
        Dictionary(uniqueKeysWithValues: try self.map { ($0, try transform($0)) })
    }
}

extension Collection {
    func sorted<C: Comparable>(by extractor: (Element) throws -> C) rethrows -> [Element] {
        try sorted { try extractor($0) < (try extractor($1)) }
    }
    
    func group<Key: Hashable>(by transform: (Element) throws -> Key) rethrows -> [Key: [Element]] {
        try reduce(into: [:]) { result, element in
            let key = try transform(element)
            result[key, default: []].append(element)
        }
    }
    
    func associate<K: Hashable>(by transform: (Element) throws -> K) rethrows -> [K: Element] {
        Dictionary(uniqueKeysWithValues: try self.map { try (transform($0), $0) })
    }
    func associate<K: Hashable, V>(_ transform: (Element) throws -> (K, V)) rethrows -> [K: V] {
        Dictionary(uniqueKeysWithValues: try self.map { try transform($0) })
    }
    
    func max<C: Comparable>(by extractor: (Element) throws -> C) rethrows -> Element? {
        try self.max { try extractor($0) < (try extractor($1)) }
    }

    /// Returns the sum of all values produced by extractor function applied to each element in the array.
    ///
    /// - Parameter extractor: a closure which converts each element of the sequence into a number.
    /// - Returns: the sum of all numbers produced by the extractor.
    func sum<N: AdditiveArithmetic>(of extractor: (Element) throws -> N) rethrows -> N {
        var sum = N.zero
        for i in self {
            sum += try extractor(i)
        }
        return sum
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

extension Collection where Element: AdditiveArithmetic {
    func sum() -> Element {
        reduce(Element.zero, +)
    }
}
