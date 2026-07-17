# BIRD.vim

<div align="center">

**Vim syntax highlighting for BIRD 2 and BIRD 3 configuration files**

English | [简体中文](README.zh-CN.md)

[![License: MPL-2.0](https://img.shields.io/badge/License-MPL--2.0-blue.svg)](LICENSE)
[![Vim](https://img.shields.io/badge/Vim-8.0+-green.svg)](https://www.vim.org/)
[![GitHub Release](https://img.shields.io/github/v/release/bird-chinese-community/BIRD.vim)](https://github.com/bird-chinese-community/BIRD.vim/releases/latest)

</div>

## Overview

`BIRD.vim` provides Vim syntax highlighting, filetype detection, and filetype plugin support for BIRD 2 and BIRD 3 configuration files.

This is the Vim plugin component of the [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) project by the BIRD Chinese Community.

> [!NOTE]
> This repository was renamed from `BIRD2.vim` to reflect support for both BIRD 2 and BIRD 3. GitHub redirects the old URL, while the `bird2` filetype, runtime filenames, mappings, and configuration variables remain compatible.

## Features

- Syntax highlighting aligned with current BIRD 2.19 and BIRD 3.3 syntax
- Automatic filetype detection for `.bird`, `.bird2`, `.bird3`, and `.conf` files
- Smart heuristic detection for generic `.conf` files
- Filetype-specific settings (comments, format options, etc.)

## Installation

### Using vim-plug

```vim
Plug 'bird-chinese-community/BIRD.vim'
```

### Using Vundle

```vim
Plugin 'bird-chinese-community/BIRD.vim'
```

### Using native packages (Vim 8+)

Clone the repository into a `start` package directory; Vim loads it
automatically during startup:

```bash
git clone https://github.com/bird-chinese-community/BIRD.vim \
  ~/.vim/pack/plugins/start/BIRD.vim
```

### Manual Installation

```bash
git clone https://github.com/bird-chinese-community/BIRD.vim.git
cd BIRD.vim
bash scripts/install.sh
```

### Release archives

Each [GitHub Release](https://github.com/bird-chinese-community/BIRD.vim/releases)
includes a directly installable ZIP, tar.gz archive, and `SHA256SUMS`. The
archives contain only the Vim runtime and include generated `doc/tags`.

## Updating

GitHub redirects the former `BIRD2.vim` repository URL, so existing checkouts continue to fetch. Update the repository name in your plugin-manager configuration, then refresh it:

```vim
" vim-plug
:PlugUpdate BIRD.vim

" Vundle
:PluginUpdate
```

For an existing native package checkout, rename its directory, update the
remote, and then pull the latest version:

```bash
mv ~/.vim/pack/plugins/start/bird2.vim \
  ~/.vim/pack/plugins/start/BIRD.vim
git -C ~/.vim/pack/plugins/start/BIRD.vim remote set-url origin \
  https://github.com/bird-chinese-community/BIRD.vim.git
git -C ~/.vim/pack/plugins/start/BIRD.vim pull --ff-only
```

For a manual checkout at another path, the directory name can remain unchanged;
update its remote and rerun the installer:

```bash
git -C /path/to/bird2.vim remote set-url origin \
  https://github.com/bird-chinese-community/BIRD.vim.git
git -C /path/to/bird2.vim pull --ff-only
bash /path/to/bird2.vim/scripts/install.sh
```

## Filetype Detection

The plugin automatically detects BIRD 2 and BIRD 3 configuration files by:

- **Extension**: `.bird`, `.bird2`, `.bird3`
- **Filename**: `bird.conf`, `bird2.conf`, `bird3.conf`, `bird6.conf`, and explicit `bird-*`/`*.bird*.conf` variants
- **Known paths**: configuration files below `bird`, `bird2`, or `bird3` directories
- **Content**: scans the first 200 lines of generic `.conf` files. Strong BIRD-only constructs are accepted immediately; generic constructs require two independent signals to reduce false positives.

## Documentation

After installation, view the help documentation:

```vim
:help bird2
```

To regenerate help tags:

```vim
:helptags ~/.vim/doc
```

See the [changelog](CHANGELOG.md) for release history. Contributors should add
a bilingual fragment following the [change-fragment guide](.changeset/README.md)
for user-visible or release-worthy changes.

## Configuration

No configuration is required. The plugin works out of the box.

### Disable heuristic detection

If you want to disable content-based detection for `.conf` files:

```vim
let g:bird2_heuristic_detect = 0
```

### Custom file extensions

To add custom file extensions:

```vim
autocmd BufRead,BufNewFile *.myext setfiletype bird2
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

- Plugin files: [Mozilla Public License 2.0](LICENSE)
- Copyright (c) BIRD Chinese Community

## Related Projects

- [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) - TextMate grammar for BIRD 2 and BIRD 3
- [BIRD.nvim](https://github.com/bird-chinese-community/BIRD.nvim) - Neovim plugin
- [vscode-bird2](https://github.com/bird-chinese-community/vscode-bird2-conf) - VS Code extension

## Acknowledgments

This plugin is maintained by the [BIRD Chinese Community](https://github.com/bird-chinese-community).
