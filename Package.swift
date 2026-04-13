// swift-tools-version: 5.9
import Foundation
import PackageDescription

// Distribution-only repo: one product, binary XeniPaySDK (no Swift sources here).
//
// After publishing a GitHub Release, integrators resolve this repo; SPM downloads the zip.
//
// Local verify (before upload): place `XeniPaySDK.xcframework.zip` next to this file — SPM
// will use the path-based binary. Omit the zip from git (see .gitignore); copy from
// xenipay-sdk after `./build_xcframework.sh`.

private let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
private let localZipPath = root.appendingPathComponent("XeniPaySDK.xcframework.zip").path
private let hasLocalZip = FileManager.default.fileExists(atPath: localZipPath)

private let releaseTag = "1.0.0"
private let remoteBinaryURL =
    "https://github.com/xeni-app/xenipay-sdk-dist/releases/download/\(releaseTag)/XeniPaySDK.xcframework.zip"

/// Must match `swift package compute-checksum` on the exact bytes uploaded to the release asset.
private let remoteBinaryChecksum =
    "afe87522f0438cc5236f527793c301480e4b9eeb6a175a780c97c2091ee73f40"

private let targets: [Target] = {
    if hasLocalZip {
        return [
            .binaryTarget(name: "XeniPaySDK", path: "XeniPaySDK.xcframework.zip"),
        ]
    }
    return [
        .binaryTarget(
            name: "XeniPaySDK",
            url: remoteBinaryURL,
            checksum: remoteBinaryChecksum
        ),
    ]
}()

let package = Package(
    name: "XeniPaySDK",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "XeniPaySDK", targets: ["XeniPaySDK"]),
    ],
    dependencies: [],
    targets: targets
)
