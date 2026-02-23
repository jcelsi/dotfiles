
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

# Fish conf.d/tide.fish
if [[ -f "$HOME/.config/fish/conf.d/tide.fish" && ! -L "$HOME/.config/fish/conf.d/tide.fish" ]]; then
  echo "Haciendo backup de conf.d/tide.fish..."
  mv "$HOME/.config/fish/conf.d/tide.fish" "$HOME/.config/fish/conf.d/tide.fish.backup"
fi

# Ejecutar stow desde el directorio de dotfiles
cd "$DOTFILES_DIR"
stow -v --target="$HOME" .

echo "Instalación completada."
