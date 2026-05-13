#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dev/dotfiles"

# =============================================================================
# 1. Instalar Homebrew si no está instalado
# =============================================================================
echo ""
echo ">> Homebrew"
if ! command -v brew &>/dev/null; then
  echo "  Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  ✓ Homebrew ya está instalado."
fi

# =============================================================================
# 2. Instalar JetBrains Mono Nerd Font
# =============================================================================
echo ""
echo ">> JetBrains Mono Nerd Font"
if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null 2>&1; then
  echo "  ✓ JetBrains Mono Nerd Font ya está instalado."
else
  echo "  Instalando JetBrains Mono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font
  echo "  ✓ JetBrains Mono Nerd Font instalado."
fi

# =============================================================================
# 3. Instalar Ghostty
# =============================================================================
echo ""
echo ">> Ghostty"
if brew list --cask ghostty &>/dev/null 2>&1; then
  echo "  ✓ Ghostty ya está instalado."
else
  echo "  Instalando Ghostty..."
  brew install --cask ghostty
  echo "  ✓ Ghostty instalado."
fi

echo ""
echo ">> Configuración de Ghostty"
mkdir -p "$HOME/.config/ghostty"
cp "$DOTFILES_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"
echo "  ✓ ghostty/config copiado."

# =============================================================================
# 4. Instalar AeroSpace
# =============================================================================
echo ""
echo ">> AeroSpace"
if brew list --cask nikitabobko/tap/aerospace &>/dev/null 2>&1; then
  echo "  ✓ AeroSpace ya está instalado."
else
  echo "  Instalando AeroSpace..."
  brew install --cask nikitabobko/tap/aerospace
  echo "  ✓ AeroSpace instalado."
fi

echo ""
echo ">> Configuración de AeroSpace"
mkdir -p "$HOME/.config/aerospace"
cp "$DOTFILES_DIR/.config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
echo "  ✓ aerospace.toml copiado."

# =============================================================================
# 5. Instalar Starship
# =============================================================================
echo ""
echo ">> Starship"
if ! command -v starship &>/dev/null; then
  echo "  Instalando Starship..."
  brew install starship
else
  echo "  ✓ Starship ya está instalado."
fi

echo ""
echo ">> Configuración de Starship"
mkdir -p "$HOME/.config"
cp "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
echo "  ✓ starship.toml copiado."

# =============================================================================
# 6. Instalar tmux
# =============================================================================
echo ""
echo ">> tmux"
if ! command -v tmux &>/dev/null; then
  echo "  Instalando tmux..."
  brew install tmux
else
  echo "  ✓ tmux ya está instalado."
fi

# =============================================================================
# 7. Instalar Neovim
# =============================================================================
echo ""
echo ">> Neovim"
if ! command -v nvim &>/dev/null; then
  echo "  Instalando Neovim..."
  brew install neovim
else
  echo "  ✓ Neovim ya está instalado."
fi

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
echo "Herramientas instaladas:"
echo "  - JetBrains Mono Nerd Font"
echo "  - Ghostty"
echo "  - AeroSpace"
echo "  - Starship"
echo "  - tmux"
echo "  - Neovim"
echo ""
echo "Neovim:"
echo "  - Abre nvim para que lazy.nvim instale los plugins automáticamente."
echo ""
echo "Abre una nueva terminal para ver los cambios."
echo ""
