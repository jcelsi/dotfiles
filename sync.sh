#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dev/dotfiles"

# Archivos/directorios a sincronizar
FISH_CONFIG="$HOME/.config/fish/config.fish"
NVIM_DIR="$HOME/.config/nvim"

usage() {
  echo "Uso: ./sync.sh [push|pull]"
  echo ""
  echo "  push  - Copia configs del repo → ~/.config"
  echo "  pull  - Copia configs de ~/.config → repo"
  echo ""
}

push_configs() {
  echo ">> Copiando configs del repo al home..."
  
  # Fish
  mkdir -p "$HOME/.config/fish"
  cp "$DOTFILES_DIR/.config/fish/config.fish" "$FISH_CONFIG"
  echo "  ✓ Fish config copiado"
  
  # Neovim
  mkdir -p "$HOME/.config/nvim/lua/plugins"
  cp "$DOTFILES_DIR/.config/nvim/init.lua" "$NVIM_DIR/init.lua"
  cp -r "$DOTFILES_DIR/.config/nvim/lua/" "$NVIM_DIR/lua/"
  echo "  ✓ Neovim config copiado"
  
  echo ""
  echo "Done!"
}

pull_configs() {
  echo ">> Copiando configs del home al repo..."
  
  # Fish
  if [ -f "$FISH_CONFIG" ]; then
    cp "$FISH_CONFIG" "$DOTFILES_DIR/.config/fish/config.fish"
    echo "  ✓ Fish config copiado"
  else
    echo "  ⚠ Fish config no encontrado en $FISH_CONFIG"
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
