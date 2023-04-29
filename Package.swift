// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "OYTimer",
    products: [
        .library(name: "OYTimer", targets: ["OYTimer"])
    ],
    targets: [
        .target(name: "OYTimer", path: "Sources")
    ]
)