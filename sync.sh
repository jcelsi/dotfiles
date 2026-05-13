#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dev/dotfiles"

# Archivos/directorios a sincronizar
STARSHIP_CONFIG="$HOME/.config/starship.toml"
NVIM_DIR="$HOME/.config/nvim"
AEROSPACE_CONFIG="$HOME/.config/aerospace/aerospace.toml"
GHOSTTY_CONFIG="$HOME/.config/ghostty/config"

usage() {
  echo "Uso: ./sync.sh [push|pull]"
  echo ""
  echo "  push  - Copia configs del repo → ~/.config"
  echo "  pull  - Copia configs de ~/.config → repo"
  echo ""
}

push_configs() {
  echo ">> Copiando configs del repo al home..."

  # Starship
  cp "$DOTFILES_DIR/.config/starship.toml" "$STARSHIP_CONFIG"
  echo "  ✓ Starship config copiado"

  # Neovim
  mkdir -p "$HOME/.config/nvim/lua/plugins"
  cp "$DOTFILES_DIR/.config/nvim/init.lua" "$NVIM_DIR/init.lua"
  cp -r "$DOTFILES_DIR/.config/nvim/lua/" "$NVIM_DIR/lua/"
  echo "  ✓ Neovim config copiado"

  # AeroSpace
  mkdir -p "$HOME/.config/aerospace"
  cp "$DOTFILES_DIR/.config/aerospace/aerospace.toml" "$AEROSPACE_CONFIG"
  echo "  ✓ AeroSpace config copiado"

  # Ghostty
  mkdir -p "$HOME/.config/ghostty"
  cp "$DOTFILES_DIR/.config/ghostty/config" "$GHOSTTY_CONFIG"
  echo "  ✓ Ghostty config copiado"

  echo ""
  echo "Done!"
}

pull_configs() {
  echo ">> Copiando configs del home al repo..."

  # Starship
  if [ -f "$STARSHIP_CONFIG" ]; then
    cp "$STARSHIP_CONFIG" "$DOTFILES_DIR/.config/starship.toml"
    echo "  ✓ Starship config copiado"
  else
    echo "  ⚠ Starship config no encontrado en $STARSHIP_CONFIG"
  fi

  # Neovim (solo init.lua y lua/, no plugins instalados ni lazy-lock)
  if [ -d "$NVIM_DIR" ]; then
    cp "$NVIM_DIR/init.lua" "$DOTFILES_DIR/.config/nvim/init.lua"
    rm -rf "$DOTFILES_DIR/.config/nvim/lua"
    cp -r "$NVIM_DIR/lua" "$DOTFILES_DIR/.config/nvim/lua"
    echo "  ✓ Neovim config copiado"
  else
    echo "  ⚠ Neovim config no encontrado en $NVIM_DIR"
  fi

  # AeroSpace
  if [ -f "$AEROSPACE_CONFIG" ]; then
    cp "$AEROSPACE_CONFIG" "$DOTFILES_DIR/.config/aerospace/aerospace.toml"
    echo "  ✓ AeroSpace config copiado"
  else
    echo "  ⚠ AeroSpace config no encontrado en $AEROSPACE_CONFIG"
  fi

  # Ghostty
  if [ -f "$GHOSTTY_CONFIG" ]; then
    cp "$GHOSTTY_CONFIG" "$DOTFILES_DIR/.config/ghostty/config"
    echo "  ✓ Ghostty config copiado"
  else
    echo "  ⚠ Ghostty config no encontrado en $GHOSTTY_CONFIG"
  fi

  echo ""
  echo "Done! No olvides hacer commit de los cambios."
}

case "$1" in
  push)
    push_configs
    ;;
  pull)
    pull_configs
    ;;
  *)
    usage
    exit 1
    ;;
esac
