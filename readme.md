# xenipay-sdk-dist

Swift Package distribution for **XeniPaySDK** (binary only). Source lives in [`xenipay-sdk`](https://github.com/xeni-app/xenipay-sdk).

**Fork:** `https://github.com/sethuramancr/xenipay-sdk-dist` (upstream: `xeni-app/xenipay-sdk-dist`).

## Integrators (Xcode / SPM)

- **Fork:** add `https://github.com/sethuramancr/xenipay-sdk-dist.git` — sample app uses **branch `main`** until you tag releases.
- **Binary zip:** `Package.swift` downloads from **your fork’s** GitHub Release (`sethuramancr/xenipay-sdk-dist`, tag `1.0.0`) when no local zip is present. Publish that release + asset, or keep a local `XeniPaySDK.xcframework.zip` for path-based resolution (see `.gitignore`).

## Publish a new binary

1. In **xenipay-sdk**, run `./build_xcframework.sh` → `XeniPaySDK.xcframework.zip`.
2. `swift package compute-checksum XeniPaySDK.xcframework.zip` → update `remoteBinaryChecksum` in `Package.swift` if the archive changed.
3. Commit and push `Package.swift`, tag (e.g. `1.0.0`).
4. **GitHub → Releases → New release** for that tag and attach **`XeniPaySDK.xcframework.zip`** (same name as in the download URL in `Package.swift`).

Private repo: ensure the **release asset** URL is fetchable by SPM (often requires a public asset URL or hosting the zip elsewhere).

## Local SPM check (optional)

```bash
cp ../xenipay-sdk/XeniPaySDK.xcframework.zip .
swift package dump-package
```

With the zip present, `Package.swift` uses a **path** binary so you can validate the manifest without hitting GitHub.
