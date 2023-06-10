// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "iOS Challenges",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Challenges",
            targets: ["Challenges"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Challenges",
            dependencies: []),
        .testTarget(
            name: "ChallengesTests",
            dependencies: ["Challenges"]),
    ]
)
