// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Launchterm",
    dependencies: [
        .package(url: "https://github.com/soffes/HotKey.git", .upToNextMinor(from: "0.1.3")),
    ],
    targets: [
        .target(name: "Launchterm", dependencies: ["HotKey"]),
    ]
)
