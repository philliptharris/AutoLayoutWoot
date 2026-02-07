// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "AutoLayoutWoot",
    products: [
        .library(name: "AutoLayoutWoot", targets: ["AutoLayoutWoot"]),
    ],
    targets: [
        .target(name: "AutoLayoutWoot"),
        .testTarget(name: "AutoLayoutWootTests", dependencies: ["AutoLayoutWoot"]),
    ]
)
