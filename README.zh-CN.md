# BIRD.vim

<div align="center">

**BIRD 2 与 BIRD 3 配置文件的 Vim 语法高亮插件**

[English](README.md) | 简体中文

[![License: MPL-2.0](https://img.shields.io/badge/License-MPL--2.0-blue.svg)](LICENSE)
[![Vim](https://img.shields.io/badge/Vim-8.0+-green.svg)](https://www.vim.org/)

</div>

## 概述

`BIRD.vim` 为 BIRD 2 与 BIRD 3 配置文件提供 Vim 语法高亮、文件类型检测和文件类型插件支持。

这是 [BIRD 中文社区](https://github.com/bird-chinese-community) 的 [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) 项目的 Vim 插件组件。

> [!NOTE]
> 本仓库已从 `BIRD2.vim` 更名为 `BIRD.vim`，以体现同时支持 BIRD 2 与 BIRD 3。GitHub 会重定向旧 URL；`bird2` filetype、运行时文件名、映射和配置变量继续保持兼容。

## 功能特性

- 与当前 BIRD 2.19 和 BIRD 3.3 对齐的配置语法高亮
- 自动文件类型检测（`.bird`, `.bird2`, `.bird3`, `.conf` 等扩展名）
- 对通用 `.conf` 文件的智能启发式检测
- 文件类型特定设置（注释、格式选项等）

## 安装

### 使用 vim-plug

```vim
Plug 'bird-chinese-community/BIRD.vim'
```

### 使用 Vundle

```vim
Plugin 'bird-chinese-community/BIRD.vim'
```

### 使用 pack.nvim (Neovim/Vim 8+)

```vim
packadd! BIRD.vim
```

或手动克隆到 pack 目录：

```bash
git clone https://github.com/bird-chinese-community/BIRD.vim \
  ~/.vim/pack/plugins/start/BIRD.vim
```

### 手动安装

```bash
git clone https://github.com/bird-chinese-community/BIRD.vim.git
cd BIRD.vim
bash scripts/install.sh
```

## 更新

GitHub 会重定向原 `BIRD2.vim` 仓库 URL，因此现有 checkout 仍可继续拉取。建议先把插件管理器配置中的仓库名改为新名称，再执行更新：

```vim
" vim-plug
:PlugUpdate BIRD.vim

" Vundle
:PluginUpdate
```

如果现有原生 package checkout 仍使用旧目录名，请重命名目录、更新 remote，再拉取最新版本：

```bash
mv ~/.vim/pack/plugins/start/bird2.vim \
  ~/.vim/pack/plugins/start/BIRD.vim
git -C ~/.vim/pack/plugins/start/BIRD.vim remote set-url origin \
  https://github.com/bird-chinese-community/BIRD.vim.git
git -C ~/.vim/pack/plugins/start/BIRD.vim pull --ff-only
```

对于位于其他路径的手动 checkout，目录名可保持不变；更新 remote 后重新运行安装器：

```bash
git -C /path/to/bird2.vim remote set-url origin \
  https://github.com/bird-chinese-community/BIRD.vim.git
git -C /path/to/bird2.vim pull --ff-only
bash /path/to/bird2.vim/scripts/install.sh
```

## 文件类型检测

插件通过以下方式自动检测 BIRD 2 与 BIRD 3 配置文件：

- **扩展名**：`.bird`、`.bird2`、`.bird3`
- **文件名**：`bird.conf`、`bird2.conf`、`bird3.conf`、`bird6.conf`，以及明确的 `bird-*`/`*.bird*.conf` 变体
- **已知路径**：位于 `bird`、`bird2` 或 `bird3` 目录下的配置文件
- **内容检测**：扫描通用 `.conf` 文件的前 200 行；BIRD 独有结构会直接命中，通用结构需要两个独立信号，从而减少误判。

## 文档

安装后，可查看帮助文档：

```vim
:help bird2
```

重新生成帮助标签：

```vim
:helptags ~/.vim/doc
```

## 配置

无需配置即可使用。

### 禁用启发式检测

如需禁用 `.conf` 文件的内容检测：

```vim
let g:bird2_heuristic_detect = 0
```

### 自定义文件扩展名

添加自定义文件扩展名：

```vim
autocmd BufRead,BufNewFile *.myext setfiletype bird2
```

## 贡献

欢迎贡献！请随时提交 Pull Request。

## 许可证

- 插件文件：[Mozilla Public License 2.0](LICENSE)
- 版权所有 (c) BIRD 中文社区

## 相关项目

- [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) - BIRD 2 与 BIRD 3 的 TextMate 语法
- [BIRD.nvim](https://github.com/bird-chinese-community/BIRD.nvim) - Neovim 插件
- [vscode-bird2](https://github.com/bird-chinese-community/vscode-bird2-conf) - VS Code 扩展

## 鸣谢

此插件由 [BIRD 中文社区](https://github.com/bird-chinese-community) 维护。
