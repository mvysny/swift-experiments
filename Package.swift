// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftExperiments",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "Exec", targets: ["Exec"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SwiftExperiments", dependencies: []),
        .executableTarget(name: "Exec", dependencies: ["SwiftExperiments"]),
        .testTarget(name: "Tests", dependencies: [
            "SwiftExperiments",
            .product(name: "Numerics", package: "swift-numerics"),
        ]),
    ]
)
