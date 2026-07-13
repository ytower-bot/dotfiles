#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LINKS=(
  "config/ghostty:$HOME/.config/ghostty"
  "config/starship.toml:$HOME/.config/starship.toml"
  "config/sheldon:$HOME/.config/sheldon"
  "nvim:$HOME/.config/nvim"
  "zshrc:$HOME/.zshrc"
)

link_it() {
  local src="$DOTFILES_DIR/${1%%:*}"
  local dest="${1#*:}"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "ok      $dest (already linked)"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="${dest}.bak-$(date +%Y%m%d%H%M%S)"
    echo "backup  $dest -> $backup"
    mv "$dest" "$backup"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "link    $src -> $dest"
}

for pair in "${LINKS[@]}"; do
  link_it "$pair"
done
