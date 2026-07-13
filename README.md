# dotfiles

My personal macOS setup: ghostty, neovim, starship, sheldon, zsh.

## Setup

```bash
./install.sh
./init.sh
```

Both are idempotent.

### install.sh

| What | How |
|---|---|
| Xcode Command Line Tools | `xcode-select --install` |
| Homebrew | official installer |
| `neovim`, `sheldon`, `starship`, `node`, `go`, `gopls`, `openjdk`, `jdtls`, `tree-sitter-cli` | `brew install` |
| `ghostty` | `brew install --cask` |
| `pyright`, `typescript-language-server`, `bash-language-server`, `typescript@5` | `npm install -g` |
| Rust + `rust-analyzer` | `rustup` + `rustup component add` |
| zsh | `chsh` |

### init.sh

| Source | Destination |
|---|---|
| `config/ghostty` | `~/.config/ghostty` |
| `config/starship.toml` | `~/.config/starship.toml` |
| `config/sheldon` | `~/.config/sheldon` |
| `nvim` | `~/.config/nvim` |
| `zshrc` | `~/.zshrc` |

`nvim` is a separate git repo cloned into `dotfiles/nvim`.

## Neovim

Plugins and LSPs are managed by Neovim's native `vim.pack`, declared in
`nvim/lua/plugins.lua`. See `:h vim.pack` to add, update, or remove plugins.

LSPs: `lua_ls`, `clangd`, `jdtls`, `pyright`, `ts_ls`, `bashls`,
`rust_analyzer`, `gopls`.

Tree-sitter: `c`, `cpp`, `java`, `python`, `typescript`, `tsx`, `bash`,
`rust`, `go`, `lua`.
