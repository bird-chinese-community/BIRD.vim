# Release process / 发布流程

This repository publishes standard SemVer tags (`vX.Y.Z`) and root-installable
ZIP and tar.gz archives. The attached archives are the supported installation
artifacts; GitHub's automatic source archives remain useful for source review.

Publishable archives must be produced on Linux with GNU tar, either in GitHub
Actions or an isolated Debian container. Archives built locally on macOS are
preflight artifacts only.

本仓库使用标准 SemVer tag（`vX.Y.Z`），并发布可直接作为 Vim runtime 安装的
ZIP 与 tar.gz 包。正式安装应优先使用 Release 附件；GitHub 自动生成的源码包
主要用于源码审阅。

## Current release / 当前版本发布

1. Consume all change fragments into `CHANGELOG.md`.
2. Confirm the runtime version, build the archives, and run the extracted-tree
   smoke test:

   ```sh
   node scripts/changeset.mjs check-release
   node scripts/release.mjs check v1.0.14
   node scripts/release.mjs package v1.0.14 dist
   node scripts/release.mjs verify v1.0.14 dist
   ```

3. Merge the reviewed release commit to the default branch.
4. Create an annotated tag on that exact commit and push it. The Release
   workflow re-runs the tests, rebuilds and verifies both archives, publishes
   `SHA256SUMS`, and reuses the matching changelog section as release notes.

不得移动或复用已经发布的 tag。若需修正内容，应发布新的 patch 版本。

## Historical backfill / 历史版本回填

The following tags are reconstructed from the first standalone commit carrying
each syntax version:

| Tag | Commit |
| --- | --- |
| `v1.0.6` | `41919c95ae07fe4c35b0f98ec61bec418dadfaae` |
| `v1.0.7` | `b1c022662b57d7b38055a09d0e734b1805df161c` |
| `v1.0.8` | `048bc1d08892a30bb2c39b1aa388ea3f32e9edfb` |
| `v1.0.9` | `27a9c371f3a5328010d6c93daa6093218a73fbd8` |
| `v1.0.11` | `189705195c4d5d18221c3b27fd632c19ee3583d1` |

`package-ref` reads files directly from the selected Git object, includes only
the runtime allowlist, generates `doc/tags`, normalizes timestamps to the source
commit, and rejects symlinks. `verify` compares extracted ZIP and tar.gz trees,
checks hashes and required paths, and launches Vim against the extracted plugin.

```sh
node scripts/release.mjs package-ref v1.0.8 \
  048bc1d08892a30bb2c39b1aa388ea3f32e9edfb dist/backfill/v1.0.8
node scripts/release.mjs verify v1.0.8 dist/backfill/v1.0.8
node scripts/release.mjs notes v1.0.8 dist/backfill/v1.0.8/release-notes.md
```

Create and push each annotated historical tag only after the mapping and package
verification have passed. Historical tag pushes do not execute workflows that
were absent from those commits, so publish their verified assets explicitly with
the corresponding changelog notes.
