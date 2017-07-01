// swift-tools-version:3.1

import Foundation
import PackageDescription

var dependencies: [Package.Dependency] = [
  .Package(url: "https://github.com/Moya/Moya.git", majorVersion: 8),
]

let isTest = ProcessInfo.processInfo.environment["TEST"] == "1"
if isTest {
  dependencies.append(
    .Package(url: "https://github.com/devxoul/Then.git", majorVersion: 2)
  )
}

let package = Package(
  name: "MoyaSugar",
  targets: [
    Target(name: "MoyaSugar"),
    Target(name: "RxMoyaSugar", dependencies: ["MoyaSugar"]),
  ],
  dependencies: dependencies
)
