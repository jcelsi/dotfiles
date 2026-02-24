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
# 3. Symlink de configuración de nvim (idempotente)
# =============================================================================
echo ""
echo ">> Configuración de Neovim"
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

# Limpiar cache/state si existen (esto es seguro y mejora la consistencia)
if [ -d "$HOME/.local/share/nvim" ] || [ -d "$HOME/.local/state/nvim" ] || [ -d "$HOME/.cache/nvim" ]; then
  echo "  Limpiando cache/state de nvim para consistencia..."
  rm -rf "$HOME/.local/share/nvim"
  rm -rf "$HOME/.local/state/nvim"
  rm -rf "$HOME/.cache/nvim"
  echo "  ✓ Cache limpiado (los plugins se reinstalarán automáticamente)"
fi

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
# 5. Symlink de configuración de Fish (idempotente)
# =============================================================================
echo ""
echo ">> Configuración de Fish"
create_symlink "$DOTFILES_DIR/.config/fish" "$HOME/.config/fish"

# =============================================================================
# 6. Instalar Fisher si no está instalado
# =============================================================================
echo ""
echo ">> Fisher (gestor de plugins de Fish)"
if [ ! -f "$HOME/.config/fish/functions/fisher.fish" ]; then
  echo "  Instalando Fisher..."
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
  echo "  ✓ Fisher instalado."
else
  echo "  ✓ Fisher ya está instalado."
fi

# =============================================================================
# 7. Instalar/actualizar plugins de Fisher (Tide, z, fzf, autopair)
# =============================================================================
echo ""
echo ">> Plugins de Fish (Tide, z, fzf, autopair)"
echo "  Ejecutando fisher update..."
fish -c 'fisher update'
echo "  ✓ Plugins instalados/actualizados."

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
echo "Fish + Tide:"
echo "  - Los colores Solarized Osaka se aplicarán automáticamente."
echo "  - Abre una nueva terminal con Fish para ver los cambios."
echo ""
