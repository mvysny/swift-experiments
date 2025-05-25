# Kotlin Koans in Swift

The [Kotlin Koans](https://play.kotlinlang.org/koans/overview), but done in the
[Swift programming language](https://www.swift.org).

This project can be opened in Linux or in MacOS:

- in Linux follow [this tutorial](https://mvysny.github.io/swift/).
- on MacOS simply open the project with XCode

In both cases:

- To build the project, run `swift build`
- To run all the tests, run `swift test`

## Testing

All koans are tested in the `KotlinKoansTest.swift` file, using the
older [XCTest framework](https://developer.apple.com/documentation/xctest).
The reason for not using the new [Swift Testing](https://developer.apple.com/documentation/testing/)
framework is that Swift Testing requires Swift 6+ while Ubuntu 25.04 only offers Swift 5.10 in the official repositories.
After Ubuntu upgrades Swift, we'll switch to Swift Testing.

Tests are implemented in the `Tests` test target (see `Package.swift` for more details). It pulls in
the common code from `SwiftExperiments` target; all tests then `@testable import SwiftExperiments`
to 'see' the code being tested.

## GitHub Actions

The project is tested using GitHub Actions. The tests are only running on [ubuntu-24.04](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md).
Since the ubuntu-24.04 image also offers Swift 6.1, there's no need to use the
[setup-swift GitHub Action](https://github.com/swift-actions/setup-swift).
