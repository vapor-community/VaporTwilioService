// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Twilio",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Twilio",
            targets: ["Twilio"]),
        ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc")
    ],
    targets: [
        .target(name: "Twilio", dependencies: [
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "ExampleApp", dependencies: [
            .target(name: "Twilio"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "ExampleRun", dependencies: [
            .target(name: "ExampleApp"),
        ]),
        .testTarget(name: "TwilioTests", dependencies: [
            .target(name: "Twilio"),
        ])
    ]
)
