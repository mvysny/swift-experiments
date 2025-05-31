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

/// https://play.kotlinlang.org/koans/Builders/Html%20builders/Task.kt

protocol HtmlNode {
    func toHtml() -> String
}
struct HtmlElement : HtmlNode {
    let tag: String
    var children: [HtmlNode] = []

    func toHtml() -> String {
        "<\(tag)>\(children.map { $0.toHtml() }.joined())</\(tag)>"
    }
}
struct HtmlText : HtmlNode {
    let text: String
    func toHtml() -> String {
        text
    }
}

@resultBuilder
struct HtmlBuilder {
    typealias Component = [HtmlNode]
    typealias Expression = HtmlNode
    static func buildExpression(_ element: Expression) -> Component {
        return [element]
    }
    static func buildBlock(_ components: Component...) -> Component {
        components.flatMap { $0 }
    }
    static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }
    static func buildOptional(_ component: Component?) -> Component {
        component != nil ? component! : []
    }
    static func buildEither(first component: Component) -> Component {
        component
    }
    static func buildEither(second component: Component) -> Component {
        component
    }
}

func html(@HtmlBuilder content: () -> [HtmlNode]) -> HtmlNode {
    HtmlElement(tag: "html", children: content())
}
func table(@HtmlBuilder content: () -> [HtmlNode]) -> HtmlNode {
    HtmlElement(tag: "table", children: content())
}
func tr(@HtmlBuilder content: () -> [HtmlNode]) -> HtmlNode {
    HtmlElement(tag: "tr", children: content())
}
func td(@HtmlBuilder content: () -> [HtmlNode]) -> HtmlNode {
    HtmlElement(tag: "td", children: content())
}
func text(_ text: String) -> HtmlNode {
    HtmlText(text: text)
}

func makeHtml() -> String {
    html {
        table {
            tr {
                td {
                    text("Product")
                }
                td {
                    text("Price")
                }
                td {
                    text("Popularity")
                }
            }
            for i in 1...2 {
                tr {
                    td {
                        text("Product \(i)")
                    }
                    td {
                        text("\(i * 100) won")
                    }
                    td {
                        text("\(i * 10)%")
                    }
                }
            }
        }
    } .toHtml()
}
