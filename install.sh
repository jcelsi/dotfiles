#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dev/dotfiles"

# =============================================================================
# Helper: Crear symlink idempotente
# =============================================================================
create_symlink() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    current_link=$(readlink "$target")
    if [ "$current_link" = "$source" ]; then
      echo "  ✓ Symlink ya existe: $target -> $source"
      return 0
    else
      echo "  Actualizando symlink: $target"
      rm "$target"
    fi
  elif [ -e "$target" ]; then
    echo "  Haciendo backup: $target -> ${target}.backup"
    mv "$target" "${target}.backup"
  fi

  ln -s "$source" "$target"
  echo "  ✓ Symlink creado: $target -> $source"
}

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
# 2. Instalar Neovim si no está instalado
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
# 3. Symlink de configuración de nvim
# =============================================================================
echo ""
echo ">> Configuración de Neovim"
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

# =============================================================================
# 4. Instalar Fish si no está instalado
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
# 5. Symlink de configuración de Fish
# =============================================================================
echo ""
echo ">> Configuración de Fish"
create_symlink "$DOTFILES_DIR/.config/fish" "$HOME/.config/fish"

# =============================================================================
# Resumen final
# =============================================================================
echo ""
echo "========================================"
echo "  Instalación completada!"
echo "========================================"
echo ""
echo "Neovim:"
echo "  - Abre nvim y Lazy instalará los plugins automáticamente."
echo ""
echo "Fish:"
echo "  - Abre una nueva terminal con Fish para ver los cambios."
echo ""
