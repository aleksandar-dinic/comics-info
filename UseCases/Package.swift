// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UseCases",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UseCases",
            targets: ["UseCases"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: ".../Domain"),
        .package(path: ".../CIData")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a
        // test suite.
        // Targets can depend on other targets in this package, and on products in packages
        // which this package depends on.
        .target(
            name: "UseCases",
            dependencies: ["Domain", "CIData"]),
        .testTarget(
            name: "UseCasesTests",
            dependencies: ["UseCases", "CIData"])
    ]
)
