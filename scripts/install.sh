#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Color support
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && [[ $(tput colors 2>/dev/null || echo 0) -ge 8 ]]; then
  BOLD="$(tput bold)"; RESET="$(tput sgr0)"
  BLUE="$(tput setaf 4)"; GREEN="$(tput setaf 2)"; YELLOW="$(tput setaf 3)"; RED="$(tput setaf 1)"
else
  BOLD=""; RESET=""; BLUE=""; GREEN=""; YELLOW=""; RED=""
fi

info() { echo -e "${BLUE}[BIRD.vim]${RESET} $*"; }
ok()   { echo -e "${GREEN}[BIRD.vim]${RESET} $*"; }
warn() { echo -e "${YELLOW}[BIRD.vim]${RESET} $*"; }
err()  { echo -e "${RED}[BIRD.vim]${RESET} $*" >&2; }

usage() {
  cat <<'EOF'
Usage: scripts/install.sh [--vim-dir PATH]
Install BIRD.vim to your Vim runtime directory.

Options:
  --vim-dir PATH    Specify custom Vim directory (default: ~/.vim)

Examples:
  scripts/install.sh
  scripts/install.sh --vim-dir ~/.config/vim
EOF
}

VIM_HOME="${VIM_HOME:-$HOME/.vim}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --vim-dir) VIM_HOME="$2"; shift 2 ;;
    *) err "Unknown option: $1"; usage; exit 2 ;;
  esac
done

info "Installing BIRD.vim to ${YELLOW}$VIM_HOME${RESET}..."

# Create directories
mkdir -p "$VIM_HOME/syntax" "$VIM_HOME/ftdetect" "$VIM_HOME/ftplugin" "$VIM_HOME/doc"

# Copy files
cp "$REPO_ROOT/syntax/bird2.vim" "$VIM_HOME/syntax/bird2.vim"
cp "$REPO_ROOT/ftdetect/bird2.vim" "$VIM_HOME/ftdetect/bird2.vim"
cp "$REPO_ROOT/ftplugin/bird2.vim" "$VIM_HOME/ftplugin/bird2.vim"
if [[ -f "$REPO_ROOT/doc/bird2.txt" ]]; then
  cp "$REPO_ROOT/doc/bird2.txt" "$VIM_HOME/doc/bird2.txt"
fi

ok "Syntax file: ${YELLOW}$VIM_HOME/syntax/bird2.vim${RESET}"
ok "Filetype detection: ${YELLOW}$VIM_HOME/ftdetect/bird2.vim${RESET}"
ok "Filetype plugin: ${YELLOW}$VIM_HOME/ftplugin/bird2.vim${RESET}"

# Generate help tags if help file exists
if [[ -f "$VIM_HOME/doc/bird2.txt" ]]; then
  if command -v vim >/dev/null 2>&1; then
    vim -c "helptags $VIM_HOME/doc" -c "q" >/dev/null 2>&1 || true
    ok "Help tags generated. Run ${GREEN}:help bird2${RESET} to view documentation."
  else
    warn "Vim not found. Please run: vim -c 'helptags $VIM_HOME/doc' -c 'q'"
  fi
fi

# Ensure Vim enables filetype/plugins/indent and syntax highlighting
ensure_vim_runtime_config() {
  local vimrc="${VIMRC:-$HOME/.vimrc}"

  if [[ -f "$vimrc" ]]; then
    cp "$vimrc" "$vimrc.bak-$(date +%Y%m%d%H%M%S)"
    info "Backed up ${YELLOW}$vimrc${RESET} to ${YELLOW}$vimrc.bak-$(date +%Y%m%d%H%M%S)${RESET}"
  fi

  touch "$vimrc"

  if ! grep -qE '^[[:space:]]*filetype plugin indent on([[:space:]]|$)' "$vimrc"; then
    printf "\nfiletype plugin indent on\n" >> "$vimrc"
    ok "Enabled in ${YELLOW}$vimrc${RESET}: filetype plugin indent on"
  else
    info "${YELLOW}$vimrc${RESET} already enables: filetype plugin indent on"
  fi

  if ! grep -qE '^[[:space:]]*syntax on([[:space:]]|$)' "$vimrc"; then
    printf "syntax on\n" >> "$vimrc"
    ok "Enabled in ${YELLOW}$vimrc${RESET}: syntax on"
  else
    info "${YELLOW}$vimrc${RESET} already enables: syntax on"
  fi
}

ensure_vim_runtime_config

ok "Installation completed!"

cat <<EOF

========================================
${BOLD}Next steps:${RESET}
- Open any BIRD2 config file to verify highlighting:
  ${GREEN}vim /etc/bird/bird.conf${RESET}
- Check filetype: ${GREEN}:verbose set ft?${RESET}
- View documentation: ${GREEN}:help bird2${RESET}
========================================
EOF
