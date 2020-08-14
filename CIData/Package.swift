// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CIData",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CIData",
            targets: ["CIData"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: ".../Domain")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a
        // test suite.
        // Targets can depend on other targets in this package, and on products in packages
        // which this package depends on.
        .target(
            name: "CIData",
            dependencies: ["Domain"]),
        .testTarget(
            name: "CIDataTests",
            dependencies: ["CIData"])
    ]
)
