# Install log

Registro de como este ambiente foi configurado numa máquina nova (macOS, Apple Silicon).

## 1. Ferramentas

Verifiquei o que já estava instalado antes de instalar qualquer coisa
(`command -v <tool>`). Resultado nesta máquina:

| Ferramenta | Estado antes | Ação |
|---|---|---|
| `starship` | instalado (Homebrew, formula) | nenhuma |
| `ghostty`  | instalado (Homebrew, cask)    | nenhuma |
| `neovim`   | não instalado                 | instalado |
| `sheldon`  | não instalado                 | instalado |

Para as duas que faltavam, consultei a documentação oficial de cada projeto
antes de decidir o método de instalação (em vez de assumir Homebrew por
padrão):

- **Neovim** — [INSTALL.md oficial](https://github.com/neovim/neovim/blob/master/INSTALL.md)
  lista Homebrew, MacPorts e tarball pré-compilado como opções para macOS,
  sem uma recomendação explícita única. Homebrew foi escolhido por já ser o
  gerenciador em uso nesta máquina (evita duplicar ferramentas de build).
- **Sheldon** — o [README do projeto](https://github.com/rossmacarthur/sheldon)
  lista Nix, Homebrew, Cargo, `cargo binstall` e binário pré-compilado via
  script. Homebrew é destacado no próprio README como a opção mais prática
  (instala completions do zsh automaticamente).

```bash
brew install neovim sheldon
```

## 2. Symlinks (`init.sh`)

O `init.sh` na raiz do repo faz o link dos arquivos de config daqui para os
locais que cada ferramenta espera. É idempotente (pode rodar quantas vezes
quiser) e faz backup (`<arquivo>.bak-<timestamp>`) de qualquer coisa real
que já exista no destino antes de substituir por um symlink.

Compatível com o `/bin/bash` 3.2 do macOS (sem arrays associativos — a Apple
não atualiza o bash por causa da licença GPLv3).

```bash
./init.sh
```

Links atuais:

| Origem (neste repo) | Destino |
|---|---|
| `config/ghostty`        | `~/.config/ghostty`   |
| `config/starship.toml`  | `~/.config/starship.toml` |
| `config/sheldon`        | `~/.config/sheldon`   |
| `nvim`                  | `~/.config/nvim`      |
| `zshrc`                 | `~/.zshrc`            |

`nvim` é um repo git separado (clonado direto dentro de `dotfiles/nvim`),
não um submodule — só um diretório normal versionado à parte.

## 3. Shell (`zshrc`)

Não havia nenhum `~/.zshrc` nesta máquina. Criei um em `zshrc` (raiz do
repo) com o mínimo necessário pra ativar o plugin manager e o prompt:

```sh
eval "$(sheldon source)"
eval "$(starship init zsh)"
```

`sheldon` lê `~/.config/sheldon/plugins.toml` (linkado acima), que hoje
declara `zsh-autosuggestions` e `zsh-syntax-highlighting`. Na primeira
execução ele clona os plugins em `~/.local/share/sheldon` e gera o lockfile
— isso já foi validado rodando `sheldon source` manualmente.

## 4. Neovim

A config em `nvim/` usa `vim.pack` (built-in do Neovim 0.12+) para
gerenciar plugins — não precisa de plugin manager externo. Na primeira
abertura do nvim ele instala automaticamente:

- fzf-lua
- gitsigns.nvim
- mini.completion
- nvim-lspconfig
- quicker.nvim

Validado com `nvim --headless -c "qa"` apontando para `~/.config/nvim`
(o symlink criado pelo `init.sh`).

## 5. Fonte

`JetBrainsMonoNL Nerd Font Mono` (referenciada em `config/ghostty/config`)
já estava instalada em `~/Library/Fonts` nesta máquina — é uma cópia
idêntica ao arquivo em `fonts/`, mas não é um symlink. Deixei como está
(fora do escopo do `init.sh` por enquanto); se for reinstalar do zero numa
máquina nova, copiar manualmente:

```bash
cp fonts/JetBrainsMonoNLNerdFontMono-Regular.ttf ~/Library/Fonts/
```

## 6. Não coberto ainda

- `hyprland` / `waybar` (mencionados no README) são específicos de
  Linux/Wayland — não se aplicam a esta máquina macOS e não têm config
  neste repo ainda.
- `pfp/` e `wallpapers/` são conteúdo estático, não config — não fazem
  parte do `init.sh`.
