#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dev/dotfiles"

# =============================================================================
# 1. Instalar Homebrew si no está instalado
# =============================================================================
echo ""
echo ">> Homebrew"
if ! command -v brew &> /dev/null; then
  echo "  Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  ✓ Homebrew ya está instalado."
fi

# =============================================================================
# 2. Instalar Nerd Fonts (Hack)
# =============================================================================
echo ""
echo ">> Nerd Fonts"
if brew list --cask font-hack-nerd-font &> /dev/null 2>&1; then
  echo "  ✓ Hack Nerd Font ya está instalado."
else
  echo "  Instalando Hack Nerd Font..."
  brew install --cask font-hack-nerd-font
  echo "  ✓ Hack Nerd Font instalado."
fi

# =============================================================================
# 3. Instalar Fish si no está instalado
# =============================================================================
echo ""
echo ">> Fish Shell"
if ! command -v fish &> /dev/null; then
  echo "  Instalando Fish..."
  brew install fish
else
  echo "  ✓ Fish ya está instalado."
fi

# =============================================================================
# 4. Configuración de Fish (copiar config.fish)
# =============================================================================
echo ""
echo ">> Configuración de Fish"
mkdir -p "$HOME/.config/fish"
cp "$DOTFILES_DIR/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
echo "  ✓ config.fish copiado."

# =============================================================================
# 5. Instalar Fisher (gestor de plugins de Fish)
# =============================================================================
echo ""
echo ">> Fisher"
echo "  Instalando Fisher..."
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
echo "  ✓ Fisher instalado."

# =============================================================================
# 6. Instalar plugins de Fish (Catppuccin)
# =============================================================================
echo ""
echo ">> Plugins de Fish (Catppuccin)"
fish -c 'fisher install catppuccin/fish'
echo "  ✓ Plugin instalado."

# =============================================================================
# 7. Instalar Starship si no está instalado
# =============================================================================
echo ""
echo ">> Starship"
if ! command -v starship &> /dev/null; then
  echo "  Instalando Starship..."
  brew install starship
else
  echo "  ✓ Starship ya está instalado."
fi

# =============================================================================
# 8. Configuración de Starship (copiar starship.toml)
# =============================================================================
echo ""
echo ">> Configuración de Starship"
mkdir -p "$HOME/.config"
cp "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
echo "  ✓ starship.toml copiado."

# =============================================================================
# 9. Instalar Neovim si no está instalado
# =============================================================================
echo ""
echo ">> Neovim"
if ! command -v nvim &> /dev/null; then
  echo "  Instalando Neovim..."
  brew install neovim
else
  echo "  ✓ Neovim ya está instalado."
fi

# =============================================================================
# 10. Configuración de Neovim (copiar config)
# =============================================================================
echo ""
echo ">> Configuración de Neovim"
mkdir -p "$HOME/.config/nvim/lua/plugins"
cp "$DOTFILES_DIR/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
cp -r "$DOTFILES_DIR/.config/nvim/lua/" "$HOME/.config/nvim/lua/"
echo "  ✓ Configuración de Neovim copiada."

# =============================================================================
# Resumen final
# =============================================================================
echo ""
echo "========================================"
echo "  Instalación completada!"
echo "========================================"
echo ""
echo "Neovim:"
echo "  - Abre nvim para que lazy.nvim instale los plugins automáticamente."
echo ""
echo "Abre una nueva terminal para ver los cambios."
echo ""
