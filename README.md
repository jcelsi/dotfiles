# dotfiles

My personal dotfiles for macOS.

## Contents

- Fish shell config
- Neovim config

## Requirements

- macOS
- [Homebrew](https://brew.sh/)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) - Powerline-patched fonts (recommended: Hack Nerd Font)

## Installation

```bash
./install.sh
```

This will:
1. Install Homebrew (if not installed)
2. Install Nerd Fonts (Hack Nerd Font)
3. Install Fish shell
4. Copy Fish config to `~/.config/fish/`
5. Install Fisher (plugin manager for Fish)
6. Install Fish plugins (Tide + Catppuccin)
7. Install Neovim
8. Copy Neovim config to `~/.config/nvim/`

### Post-installation

After running the install script:

```fish
# Configure Tide prompt
tide configure
```

Open Neovim to let lazy.nvim install plugins automatically.

## Syncing configs

Use `sync.sh` to keep your configs in sync:

```bash
# Copy configs from repo to ~/.config
./sync.sh push

# Copy configs from ~/.config to repo
./sync.sh pull
```

## Fish shell

- [Fish shell](https://fishshell.com/) - Smart and user-friendly command line shell
- [Fisher](https://github.com/jorgebucaran/fisher) - Plugin manager for Fish
- [Tide](https://github.com/IlanCosman/tide) - Modern prompt for Fish
- [Catppuccin for Fish](https://github.com/catppuccin/fish) - Soothing pastel theme

## Neovim

- [Neovim](https://neovim.io/) - Hyperextensible Vim-based text editor
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager for Neovim
- [Catppuccin for Neovim](https://github.com/catppuccin/nvim) - Soothing pastel theme
