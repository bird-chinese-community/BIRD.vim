# Changelog 🕊️

<!-- markdownlint-disable MD024 -->

All notable changes to BIRD.vim are documented in this file.

本文记录 BIRD.vim 的重要变更。

> The bundled syntax describes BIRD configuration syntax for editors. It does
> not implement or claim coverage of upstream BIRD runtime semantic changes.
>
> 内置语法用于描述编辑器中的 BIRD 配置语法，不实现也不声称覆盖 BIRD 上游
> 运行时语义变化。

<!-- changeset-release-marker -->

## [1.0.14] - 2026-07-19

### 🐛 Fixed / 修复

- 🐛 **修复 MPL-2.0 许可证正文与识别信息** / **Fix MPL-2.0 license text and detection**

  此前的 LICENSE 文件在标准 MPL-2.0 正文中混入了不相关条款，导致 GitHub 将仓库许可证识别为 “Other”，v1.0.13 安装包也携带了该错误正文。本版本恢复 Mozilla 发布的标准 MPL-2.0 全文，使仓库元数据和新生成的安装包一致、正确地声明 MPL-2.0。

  The previous LICENSE file mixed unrelated clauses into the MPL-2.0 text, causing GitHub to identify the repository license as “Other” and the v1.0.13 archives to carry the incorrect text. This release restores Mozilla's canonical MPL-2.0 text so repository metadata and newly generated archives consistently declare MPL-2.0.

## [1.0.13] - 2026-07-17

### ✨ Added / 新增

- 🛰️ **BIRD 2.19 与 BIRD 3.3 配置语法** / **BIRD 2.19 and BIRD 3.3 configuration syntax**

  同步最新及较少使用的关键字、枚举、CLI 短语、运行时/接口属性、BGP
  hidden/unknown attributes、`mac` / `mac set` 类型及 `bt_check_assign`。

  Synchronized current and uncommon keywords, enums, CLI phrases,
  runtime/interface attributes, BGP hidden/unknown attributes, `mac` / `mac set`
  types, and `bt_check_assign`.

- 🧭 **精确名称与目录识别** / **Exact filename and directory detection**

  新增 `.bird`、`.bird2`、`.bird3`、规范配置文件名，以及 `bird`、`bird2`、
  `bird3` 配置目录的精确识别。

  Added exact detection for `.bird`, `.bird2`, `.bird3`, canonical
  configuration filenames, and files under `bird`, `bird2`, or `bird3`
  configuration directories.

- 💬 **可逆的注释映射** / **Reversible comment mappings**

  新增 buffer-local 普通模式与可视模式注释映射，并保留用户已有的
  `<Leader>c` 等映射；ftplugin 清理逻辑保持可逆。

  Added buffer-local normal and visual comment mappings while preserving user
  mappings such as `<Leader>c`; ftplugin cleanup remains reversible.

### 🔧 Changed / 变更

- 🔎 **有界、注释感知的启发式检测** / **Bounded, comment-aware heuristics**

  通用 `.conf` 文件仅扫描前 200 行并忽略注释。BIRD 独有结构可直接命中，
  较通用结构必须同时出现两个独立信号；已有的非 `conf` filetype 不会被覆盖。

  Generic `.conf` files are scanned only through the first 200 lines with
  comments ignored. BIRD-specific structures match directly, while generic
  structures require two independent signals; existing non-`conf` filetypes
  are preserved.

- 🔄 **支持稍后写入的配置内容** / **Late-populated configuration support**

  新增 `FileType conf` 与 `BufWritePost` 检测路径，可识别打开后才写入或生成的
  BIRD 配置。

  Added `FileType conf` and `BufWritePost` detection paths for BIRD
  configurations populated or generated after opening.

- 🧾 **引入可审计的变更片段** / **Adopt auditable change fragments**

  新增零依赖的变更片段工作流，可在 PR 中记录语义版本级别和双语发布说明，
  并在发布时按分类汇总到 CHANGELOG。

  Added a dependency-free change-fragment workflow that records semantic
  version bumps and bilingual release notes in pull requests, then groups them
  into the changelog during release preparation.

### 🐛 Fixed / 修复

- 🐦 **降低通用 `.conf` 误识别** / **Reduced generic `.conf` false positives**

  文件名仅包含 `bird` 不再触发识别，`bluebird.conf`、`hummingbird.conf` 以及
  nginx、Apache 等配置不会因为单个弱信号而被误判。

  A filename merely containing `bird` no longer triggers detection. Files such
  as `bluebird.conf`, `hummingbird.conf`, and nginx or Apache configurations are
  not classified from a single weak signal.

- 🗃️ **typed table 识别边界** / **Typed-table detection boundaries**

  正确识别 `eth table`、`neighbor table` 与 `ipv6 sadr table`，同时排除并非
  table 声明的 address-family 标签。

  Correctly recognizes `eth table`, `neighbor table`, and `ipv6 sadr table`
  without treating address-family labels as table declarations.

- 🧵 **字符串、操作符与前缀匹配** / **Strings, operators, and prefix matching**

  修复双引号转义、位运算符冲突、压缩 IPv6 前缀和 IPv4/IPv6 prefix range，
  并限制 IPv6 正则边界以避免异常长行产生额外开销。

  Fixed double-quoted escapes, bitwise-operator collisions, compressed IPv6
  prefixes, and IPv4/IPv6 prefix ranges, while bounding IPv6 matching on
  unusually long lines.

### 🧪 Verification / 验证

- 新增 headless syntax group、filetype detection 与 ftplugin 回归测试。
- Added headless syntax-group, filetype-detection, and ftplugin regressions.
- CI 覆盖 Vim `v8.2.0000` 与 stable，且语法文件与共享 canonical snapshot
  保持逐字节一致。
- CI covers Vim `v8.2.0000` and stable and verifies that the syntax file is
  byte-identical to the canonical shared snapshot.

### 🔌 Compatibility / 兼容性

- 仓库由 BIRD2.vim 更名为 BIRD.vim，并提供 vim-plug、Vundle、原生 packages
  与手动 checkout 的双语迁移步骤。
- The repository was renamed from BIRD2.vim to BIRD.vim with bilingual
  migration steps for vim-plug, Vundle, native packages, and manual checkouts.
- 对外 filetype 仍为 `bird2`；既有 autocmd、映射、配置变量、runtime 文件名与
  `:help bird2` 均继续可用。
- The public filetype remains `bird2`; existing autocmds, mappings,
  configuration variables, runtime filenames, and `:help bird2` references
  continue to work.

## [1.0.11] - 2026-06-11

### 🔧 Changed / 变更

- 🏷️ **同步语法快照版本** / **Synchronized syntax snapshot version**

  将独立 Vim 插件中的语法版本更新为 `1.0.11-20260611`，与
  BIRD-tm-language-grammar 同期发布的 Vim syntax 快照保持一致；本版本不改变
  既有 filetype、映射或配置接口。

  Updated the standalone Vim plugin to syntax snapshot `1.0.11-20260611`,
  matching the Vim syntax release from BIRD-tm-language-grammar without
  changing the existing filetype, mappings, or configuration interface.

## [1.0.9] - 2026-03-06

### 🐛 Fixed / 修复

- 🛰️ **对齐 BGP neighbor 与 local AS 高亮** / **Aligned BGP neighbor and local AS highlighting**

  修正 `neighbor` 与 `local as` 相关语法覆盖，使 Vim 高亮与解析器支持的 BGP
  配置形式保持一致，并同步版本为 `1.0.9-20260306`。

  Corrected syntax coverage around `neighbor` and `local as` so Vim
  highlighting matches the BGP forms accepted by the parser, and synchronized
  the snapshot version to `1.0.9-20260306`.

## [1.0.8] - 2026-03-01

### ✨ Added / 新增

- 🔤 **扩展协议、属性与短语覆盖** / **Expanded protocol, property, and phrase coverage**

  补充协议与地址关键字、CLI 多词短语、byte string 与属性规则，并完善 BIRD
  配置中较少使用的语法元素。

  Added protocol and address keywords, multi-word CLI phrases, byte-string
  handling, property rules, and less common BIRD configuration constructs.

### 🐛 Fixed / 修复

- ⚙️ **修正操作符与 RPKI 高亮** / **Corrected operators and RPKI highlighting**

  收紧操作符匹配，修正 `retry` 等 RPKI 关键字分类，并避免通用规则覆盖更具体
  的语法组。

  Tightened operator matching, corrected RPKI keyword classification including
  `retry`, and prevented generic rules from shadowing more specific groups.

## [1.0.7] - 2026-02-28

### 🐛 Fixed / 修复

- 🔐 **补齐 RPKI 协议关键字** / **Completed RPKI protocol keywords**

  补充缺失的 RPKI 配置关键字并更新内置 vimdoc，使独立插件与
  `1.0.7-20260228` 语法快照一致。

  Added missing RPKI configuration keywords and updated the bundled vimdoc to
  match syntax snapshot `1.0.7-20260228`.

## [1.0.6] - 2025-12-24

### ✨ Added / 新增

- 🐦 **首个独立 Vim 插件版本** / **Initial standalone Vim plugin**

  从 BIRD-tm-language-grammar 拆分出可独立安装的 Vim runtime，包含 BIRD 2
  syntax、filetype detection、ftplugin、双语 README、vimdoc 与安装脚本。

  Extracted a standalone Vim runtime from BIRD-tm-language-grammar with BIRD 2
  syntax, filetype detection, an ftplugin, bilingual READMEs, vimdoc, and an
  installation script.

[1.0.14]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.14
[1.0.13]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.13
[1.0.11]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.11
[1.0.9]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.9
[1.0.8]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.8
[1.0.7]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.7
[1.0.6]: https://github.com/bird-chinese-community/BIRD.vim/releases/tag/v1.0.6
