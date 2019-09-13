// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "MoyaSugar",
  platforms: [
    .macOS(.v10_11), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)
  ],
  products: [
    .library(name: "MoyaSugar", targets: ["MoyaSugar"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0-beta.2")),
    .package(url: "https://github.com/devxoul/Immutable.git", .upToNextMajor(from: "0.5.0")),
    .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "2.2.0")),
  ],
  targets: [
    .target(name: "MoyaSugar", dependencies: ["Moya"]),
    .testTarget(name: "MoyaSugarTests", dependencies: ["MoyaSugar", "Immutable", "Then"]),
  ]
)
