
#!/usr/bin/env bash
set -e

# Instala Homebrew si no está instalado
if ! command -v brew &> /dev/null; then
	echo "Instalando Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Actualiza Homebrew
echo "Actualizando Homebrew..."
brew update

# Instala aplicaciones y herramientas

# iTerm2
if [[ ! -d "/Applications/iTerm.app" ]]; then
  echo "Instalando iTerm2..."
  brew install --cask iterm2
else
  echo "iTerm2 ya está instalado, omitiendo..."
fi

# Fish
if ! command -v fish &> /dev/null; then
  echo "Instalando Fish..."
  brew install fish
  echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
  chsh -s /opt/homebrew/bin/fish
else
  echo "Fish ya está instalado, omitiendo..."
fi

# Fisher (plugin manager para Fish)
if ! fish -c "type -q fisher" &> /dev/null; then
  echo "Instalando Fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
else
  echo "Fisher ya está instalado, omitiendo..."
fi

# Instalar/actualizar plugins de Fish
echo "Instalando plugins de Fish..."
fish -c "fisher update"

# Neovim
if ! command -v nvim &> /dev/null; then
  echo "Instalando Neovim..."
  brew install neovim
else
  echo "Neovim ya está instalado, omitiendo..."
fi

# tmux
if ! command -v tmux &> /dev/null; then
  echo "Instalando tmux..."
  brew install tmux
else
  echo "tmux ya está instalado, omitiendo..."
fi

# fzf (requerido para fzf.fish)
if ! command -v fzf &> /dev/null; then
  echo "Instalando fzf..."
  brew install fzf
else
  echo "fzf ya está instalado, omitiendo..."
fi

# Hack Nerd Font
if ! brew list --cask font-hack-nerd-font &> /dev/null; then
  echo "Instalando Hack Nerd Font..."
  brew install --cask font-hack-nerd-font
else
  echo "Hack Nerd Font ya está instalada, omitiendo..."
fi

# GNU Stow
if ! command -v stow &> /dev/null; then
  echo "Instalando GNU Stow..."
  brew install stow
else
  echo "GNU Stow ya está instalado, omitiendo..."
fi

# Configurar dotfiles con stow
echo "Configurando dotfiles con stow..."

DOTFILES_DIR="$HOME/dev/dotfiles"

# Crear directorio ~/.config si no existe
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/fish/conf.d"

# Backup y eliminar archivos existentes que serán reemplazados por symlinks
# Solo eliminamos si NO son ya symlinks (para permitir re-ejecución del script)

# Fish config.fish
if [[ -f "$HOME/.config/fish/config.fish" && ! -L "$HOME/.config/fish/config.fish" ]]; then
  echo "Haciendo backup de config.fish..."
  mv "$HOME/.config/fish/config.fish" "$HOME/.config/fish/config.fish.backup"
fi

# Fish fish_plugins
if [[ -f "$HOME/.config/fish/fish_plugins" && ! -L "$HOME/.config/fish/fish_plugins" ]]; then
  echo "Haciendo backup de fish_plugins..."
  mv "$HOME/.config/fish/fish_plugins" "$HOME/.config/fish/fish_plugins.backup"
fi

# Fish conf.d/solarized-osaka.fish (reemplaza tide.fish)
if [[ -f "$HOME/.config/fish/conf.d/solarized-osaka.fish" && ! -L "$HOME/.config/fish/conf.d/solarized-osaka.fish" ]]; then
  echo "Haciendo backup de conf.d/solarized-osaka.fish..."
  mv "$HOME/.config/fish/conf.d/solarized-osaka.fish" "$HOME/.config/fish/conf.d/solarized-osaka.fish.backup"
fi

# Neovim config - backup si existe y no es symlink
if [[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
  echo "Haciendo backup de configuración de nvim existente..."
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Limpiar datos de nvim anteriores (plugins, cache, state)
# Esto asegura una instalación limpia de los plugins de kickstart
if [[ -d "$HOME/.local/share/nvim" ]]; then
  echo "Limpiando plugins de nvim anteriores..."
  rm -rf "$HOME/.local/share/nvim"
fi
if [[ -d "$HOME/.local/state/nvim" ]]; then
  rm -rf "$HOME/.local/state/nvim"
fi
if [[ -d "$HOME/.cache/nvim" ]]; then
  rm -rf "$HOME/.cache/nvim"
fi

# Ejecutar stow desde el directorio de dotfiles
cd "$DOTFILES_DIR"
stow -v --target="$HOME" .

# =============================================================================
# Configurar iTerm2 con tema Solarized Osaka
# =============================================================================
echo ""
echo "Configurando iTerm2..."
if [[ -f "$DOTFILES_DIR/scripts/iterm-setup.sh" ]]; then
  bash "$DOTFILES_DIR/scripts/iterm-setup.sh"
else
  echo "Script de iTerm2 no encontrado, omitiendo..."
fi

echo ""
echo "========================================"
echo "  Instalación completada!"
echo "========================================"
echo ""
echo "Próximos pasos:"
echo "  1. Reinicia iTerm2 (Cmd+Q y vuelve a abrir)"
echo "  2. Abre Neovim y ejecuta :Lazy sync"
echo "  3. Los colores de Fish se aplicarán automáticamente"
echo ""
