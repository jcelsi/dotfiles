#!/usr/bin/env bash
# =============================================================================
# iTerm2 Configuration Script - Solarized Osaka Theme
# https://github.com/craftzdog/solarized-osaka.nvim
#
# Este script configura iTerm2 con:
# - Paleta de colores Solarized Osaka
# - Hack Nerd Font como fuente
# - Configuraciones optimizadas para desarrollo
# =============================================================================

set -e

# Verificar que estamos en macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Este script solo funciona en macOS"
    exit 1
fi

# Verificar que iTerm2 está instalado
if [[ ! -d "/Applications/iTerm.app" ]]; then
    echo "iTerm2 no está instalado. Instálalo primero con: brew install --cask iterm2"
    exit 1
fi

echo "Configurando iTerm2 con tema Solarized Osaka..."

# =============================================================================
# Paleta de Colores Solarized Osaka
# Los colores se definen en formato de diccionario para iTerm2
# Cada color tiene componentes Red, Green, Blue, Alpha (0.0 - 1.0)
# =============================================================================

# Función auxiliar para convertir hex a componentes RGB (0.0 - 1.0)
hex_to_rgb() {
    local hex="${1#\#}"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    printf "%.10f %.10f %.10f" "$(echo "scale=10; $r/255" | bc)" "$(echo "scale=10; $g/255" | bc)" "$(echo "scale=10; $b/255" | bc)"
}

# Colores Solarized Osaka
# Base colors
BASE04="001419"   # Background (más oscuro)
BASE03="002b38"   # Background alternativo
BASE02="073642"   # Selection/Highlights
BASE01="576d74"   # Comments / Bright Black
BASE0="839395"    # Foreground
BASE1="a6b5b5"    # Light foreground

# ANSI Colors
BLACK="001419"
RED="db302d"
GREEN="849900"
YELLOW="b28500"
BLUE="2c8fc2"
MAGENTA="d23681"
CYAN="29a298"
WHITE="839395"

# Bright ANSI Colors
BRIGHT_BLACK="576d74"
BRIGHT_RED="f76563"
BRIGHT_GREEN="b4fa00"
BRIGHT_YELLOW="ffcc00"
BRIGHT_BLUE="70c8ff"
BRIGHT_MAGENTA="ff6ac1"
BRIGHT_CYAN="33ddcc"
BRIGHT_WHITE="a6b5b5"

# =============================================================================
# Obtener el GUID del perfil por defecto
# =============================================================================

# Primero, intentar obtener el GUID del perfil Default
DEFAULT_GUID=$(defaults read com.googlecode.iterm2 "Default Bookmark Guid" 2>/dev/null || echo "")

if [[ -z "$DEFAULT_GUID" ]]; then
    # Si no existe, crear uno nuevo basado en el perfil "Default"
    DEFAULT_GUID="Solarized-Osaka-$(uuidgen)"
    echo "Creando nuevo perfil con GUID: $DEFAULT_GUID"
fi

# =============================================================================
# Crear archivo de perfil dinámico
# iTerm2 carga automáticamente perfiles desde DynamicProfiles
# =============================================================================

DYNAMIC_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
mkdir -p "$DYNAMIC_PROFILES_DIR"

cat > "$DYNAMIC_PROFILES_DIR/SolarizedOsaka.json" << 'PROFILE_EOF'
{
  "Profiles": [
    {
      "Name": "Solarized Osaka",
      "Guid": "solarized-osaka-profile",
      "Dynamic Profile Parent Name": "Default",
      
      "Use Non-ASCII Font": false,
      "Normal Font": "HackNerdFont-Regular 14",
      "Non Ascii Font": "HackNerdFont-Regular 14",
      "Horizontal Spacing": 1.0,
      "Vertical Spacing": 1.1,
      "Use Bold Font": true,
      "Use Italic Font": true,
      "Use Ligatures": false,
      "ASCII Ligatures": false,
      
      "Cursor Type": 1,
      "Cursor Text Color": {
        "Red Component": 0.0,
        "Green Component": 0.078431372,
        "Blue Component": 0.098039216,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Cursor Color": {
        "Red Component": 0.51372549,
        "Green Component": 0.576470588,
        "Blue Component": 0.584313725,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Cursor Boost": 0.0,
      "Blinking Cursor": false,
      
      "Background Color": {
        "Red Component": 0.0,
        "Green Component": 0.078431372,
        "Blue Component": 0.098039216,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Foreground Color": {
        "Red Component": 0.51372549,
        "Green Component": 0.576470588,
        "Blue Component": 0.584313725,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Bold Color": {
        "Red Component": 0.650980392,
        "Green Component": 0.709803922,
        "Blue Component": 0.709803922,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Selection Color": {
        "Red Component": 0.0274509804,
        "Green Component": 0.211764706,
        "Blue Component": 0.258823529,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Selected Text Color": {
        "Red Component": 0.650980392,
        "Green Component": 0.709803922,
        "Blue Component": 0.709803922,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      
      "Ansi 0 Color": {
        "Red Component": 0.0,
        "Green Component": 0.078431372,
        "Blue Component": 0.098039216,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 1 Color": {
        "Red Component": 0.858823529,
        "Green Component": 0.188235294,
        "Blue Component": 0.176470588,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 2 Color": {
        "Red Component": 0.517647059,
        "Green Component": 0.6,
        "Blue Component": 0.0,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 3 Color": {
        "Red Component": 0.698039216,
        "Green Component": 0.521568627,
        "Blue Component": 0.0,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 4 Color": {
        "Red Component": 0.17254902,
        "Green Component": 0.560784314,
        "Blue Component": 0.760784314,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 5 Color": {
        "Red Component": 0.823529412,
        "Green Component": 0.211764706,
        "Blue Component": 0.505882353,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 6 Color": {
        "Red Component": 0.160784314,
        "Green Component": 0.635294118,
        "Blue Component": 0.596078431,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 7 Color": {
        "Red Component": 0.51372549,
        "Green Component": 0.576470588,
        "Blue Component": 0.584313725,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 8 Color": {
        "Red Component": 0.341176471,
        "Green Component": 0.427450980,
        "Blue Component": 0.454901961,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 9 Color": {
        "Red Component": 0.968627451,
        "Green Component": 0.396078431,
        "Blue Component": 0.388235294,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 10 Color": {
        "Red Component": 0.705882353,
        "Green Component": 0.980392157,
        "Blue Component": 0.0,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 11 Color": {
        "Red Component": 1.0,
        "Green Component": 0.8,
        "Blue Component": 0.0,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 12 Color": {
        "Red Component": 0.439215686,
        "Green Component": 0.784313725,
        "Blue Component": 1.0,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 13 Color": {
        "Red Component": 1.0,
        "Green Component": 0.415686275,
        "Blue Component": 0.756862745,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 14 Color": {
        "Red Component": 0.2,
        "Green Component": 0.866666667,
        "Blue Component": 0.8,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Ansi 15 Color": {
        "Red Component": 0.650980392,
        "Green Component": 0.709803922,
        "Blue Component": 0.709803922,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      
      "Link Color": {
        "Red Component": 0.17254902,
        "Green Component": 0.560784314,
        "Blue Component": 0.760784314,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      
      "Transparency": 0.0,
      "Blur": false,
      "Blur Radius": 0.0,
      
      "Columns": 120,
      "Rows": 36,
      
      "Scrollback Lines": 10000,
      "Unlimited Scrollback": false,
      
      "Option Key Sends": 2,
      "Right Option Key Sends": 2,
      
      "Terminal Type": "xterm-256color",
      "Character Encoding": 4,
      
      "Close Sessions On End": true,
      "Prompt Before Closing 2": 0,
      
      "Custom Directory": "No",
      
      "Working Directory": "",
      "Use Custom Command": "No",
      "Initial Text": "",
      
      "Minimum Contrast": 0.0,
      
      "Flashing Bell": false,
      "Visual Bell": true,
      "Silence Bell": false,
      
      "Draw Powerline Glyphs": true,
      "Badge Color": {
        "Red Component": 1.0,
        "Green Component": 0.0,
        "Blue Component": 0.0,
        "Alpha Component": 0.5,
        "Color Space": "sRGB"
      },
      "Tab Color": {
        "Red Component": 0.0,
        "Green Component": 0.168627451,
        "Blue Component": 0.219607843,
        "Alpha Component": 1.0,
        "Color Space": "sRGB"
      },
      "Use Tab Color": true,
      
      "Thin Strokes": 3,
      "ASCII Anti Aliased": true,
      "Non-ASCII Anti Aliased": true,
      "Ambiguous Double Width": false,
      "Unicode Normalization": 0,
      "Unicode Version": 9,
      
      "Use Custom Window Title": false,
      "Custom Window Title": "",
      "Show Mark Indicators": true
    }
  ]
}
PROFILE_EOF

echo "Perfil dinámico creado en: $DYNAMIC_PROFILES_DIR/SolarizedOsaka.json"

# =============================================================================
# Configurar el perfil como predeterminado
# =============================================================================

# Esperar un momento para que iTerm2 cargue el perfil dinámico
echo "Configurando preferencias de iTerm2..."

# Establecer el perfil Solarized Osaka como predeterminado
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "solarized-osaka-profile"

# Configuraciones globales de iTerm2
defaults write com.googlecode.iterm2 "PromptOnQuit" -bool false
defaults write com.googlecode.iterm2 "OnlyWhenMoreTabs" -bool false
defaults write com.googlecode.iterm2 "QuitWhenAllWindowsClosed" -bool false
defaults write com.googlecode.iterm2 "HideTab" -bool false
defaults write com.googlecode.iterm2 "TabStyleWithAutomaticOption" -int 5
defaults write com.googlecode.iterm2 "HideScrollbar" -bool true
defaults write com.googlecode.iterm2 "SplitPaneDimmingAmount" -float 0.15
defaults write com.googlecode.iterm2 "DimOnlyText" -bool true
defaults write com.googlecode.iterm2 "EnableDivisionView" -bool false

# Habilitar la integración del shell
defaults write com.googlecode.iterm2 "EnableShellIntegration" -bool true

echo ""
echo "========================================"
echo "  iTerm2 configurado exitosamente!"
echo "========================================"
echo ""
echo "Cambios aplicados:"
echo "  - Tema: Solarized Osaka"
echo "  - Fuente: Hack Nerd Font 14pt"
echo "  - Cursor: Barra vertical"
echo "  - Terminal: xterm-256color"
echo ""
echo "IMPORTANTE:"
echo "  1. Cierra iTerm2 completamente (Cmd+Q)"
echo "  2. Vuelve a abrirlo"
echo "  3. Ve a Preferences > Profiles"
echo "  4. Selecciona 'Solarized Osaka' y haz clic en 'Set as Default'"
echo ""
echo "Si la fuente no se ve correctamente, asegúrate de que"
echo "Hack Nerd Font esté instalada: brew install --cask font-hack-nerd-font"
echo ""
