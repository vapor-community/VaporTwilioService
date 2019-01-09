// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Twilio",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Twilio",
            targets: ["Twilio"]),
        ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "Twilio", dependencies: ["Vapor"]),
        .target(name: "App", dependencies: ["Vapor", "Twilio"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
