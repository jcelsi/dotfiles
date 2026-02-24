# Fisher - Plugin manager for Fish
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end

# Tide prompt (install with: fisher install IlanCosman/tide@v6)
# Catppuccin theme (install with: fisher install catppuccin/fish)

# Set Catppuccin Mocha theme
fish_config theme choose "Catppuccin Mocha"
