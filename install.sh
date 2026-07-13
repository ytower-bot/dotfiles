#!/usr/bin/env bash
set -euo pipefail

have() { command -v "$1" >/dev/null 2>&1; }

if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools"
  xcode-select --install
  echo "Finish the install prompt, then re-run this script."
  exit 1
fi

if ! have brew; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "==> Installing packages"
brew install \
  neovim \
  sheldon \
  starship \
  node \
  go \
  gopls \
  openjdk \
  jdtls \
  tree-sitter-cli
brew install --cask ghostty

echo "==> Installing Node-based language servers"
npm install -g \
  pyright \
  typescript-language-server \
  bash-language-server \
  typescript@5 # ts_ls needs the classic tsserver.js; `typescript@latest` is now TS7 and dropped it

echo "==> Installing Rust"
if ! have rustup; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile default
fi
"$HOME/.cargo/bin/rustup" component add rust-analyzer

if [[ "$SHELL" != */zsh ]]; then
  chsh -s "$(command -v zsh)"
fi

echo "==> Done. Next: ./init.sh"
