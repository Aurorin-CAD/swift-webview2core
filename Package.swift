// swift-tools-version: 5.10

import PackageDescription

// Approachable Concurrency settings for Swift 6.2
let approachableConcurrencySettings: [SwiftSetting] = [
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableUpcomingFeature("GlobalActorIsolatedTypesUsability"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("InferSendableFromCaptures"),
    // .enableUpcomingFeature("NonisolatedNonsendingByDefault")
]

let defaultMainActorIsolationSettings = approachableConcurrencySettings + [
    .unsafeFlags(["-Xfrontend", "-default-isolation", "-Xfrontend", "MainActor"])
]

let package = Package(
    name: "swift-webview2core",
    products: [
        .library(name: "WebView2Core", type: .dynamic, targets: ["WebView2Core"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/thebrowsercompany/swift-cwinrt",
            revision: "eb46cdb66f770a1e006f9fcfebbf9e99a0fba811"
        ),
        .package(
            url: "https://github.com/Aurorin-CAD/swift-uwp",
            revision: "c23402e4cbfdb7a557d3aa0cfdf78c046bed7f4e"
        ),
        .package(
            url: "https://github.com/Aurorin-CAD/swift-windowsfoundation",
            revision: "d42769d70552fe59fade6fdf44bfb71c86101db7"
        ),
    ],
    targets: [
        .target(
            name: "WebView2Core",
            dependencies: [
                .product(name: "CWinRT", package: "swift-cwinrt"),
                .product(name: "UWP", package: "swift-uwp"),
                .product(name: "WindowsFoundation", package: "swift-windowsfoundation"),
            ],
            swiftSettings: defaultMainActorIsolationSettings
        )
    ]
)
