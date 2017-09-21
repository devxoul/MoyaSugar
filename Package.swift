// swift-tools-version:3.1

import Foundation
import PackageDescription

var dependencies: [Package.Dependency] = [
  .Package(url: "https://github.com/Moya/Moya.git", majorVersion: 9),
]

let isTest = ProcessInfo.processInfo.environment["TEST"] == "1"
if isTest {
  dependencies.append(contentsOf: [
    .Package(url: "https://github.com/devxoul/Immutable.git", majorVersion: 0),
    .Package(url: "https://github.com/devxoul/Then.git", majorVersion: 2),
  ])
}

let package = Package(
  name: "MoyaSugar",
  targets: [
    Target(name: "MoyaSugar"),
  ],
  dependencies: dependencies
)
