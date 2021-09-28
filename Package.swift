// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "MoyaSugar",
  platforms: [
    .macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v3)
  ],
  products: [
    .library(name: "MoyaSugar", targets: ["MoyaSugar"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
    .package(url: "https://github.com/devxoul/Immutable.git", .upToNextMajor(from: "0.5.0")),
    .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "2.2.0")),
  ],
  targets: [
    .target(name: "MoyaSugar", dependencies: ["Moya"]),
    .testTarget(name: "MoyaSugarTests", dependencies: ["MoyaSugar", "Immutable", "Then"]),
  ]
)
