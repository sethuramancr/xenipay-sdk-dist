# xenipay-sdk-dist

Swift Package distribution for **XeniPaySDK** (binary only). Source lives in [`xenipay-sdk`](https://github.com/xeni-app/xenipay-sdk).

## Integrators (Xcode / SPM)

- **After you publish:** add `https://github.com/xeni-app/xenipay-sdk-dist.git` with **Exact** version **1.0.0** (or your tag). Requires a **GitHub Release** with `XeniPaySDK.xcframework.zip` at the URL in `Package.swift`.
- **Until then (local monorepo):** point Xcode at the **local folder** `../xenipay-sdk-dist` and keep `XeniPaySDK.xcframework.zip` next to `Package.swift` so SPM uses the path-based binary (see `.gitignore` — do not commit the zip).

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
