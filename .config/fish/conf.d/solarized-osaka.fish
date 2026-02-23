# Solarized Osaka Theme for Fish + Tide
# https://github.com/craftzdog/solarized-osaka.nvim
#
# Una configuración coherente de colores para Fish shell y Tide prompt
# basada en la paleta Solarized Osaka

# =============================================================================
# Paleta de Colores Solarized Osaka
# =============================================================================
set -l base04 001419      # Fondo más oscuro
set -l base03 002b38      # Fondo
set -l base02 073642      # Fondo highlights
set -l base01 576d74      # Comentarios / texto secundario
set -l base00 657b83      # Contenido opcional
set -l base0 839395       # Texto principal (foreground)
set -l base1 a6b5b5       # Texto secundario claro

set -l red db302d         # Errores
set -l orange c94c16      # Operadores, end
set -l yellow b28500      # Strings, quotes
set -l green 849900       # Operadores, success
set -l cyan 29a298        # Comandos
set -l blue 2c8fc2        # Variables, links
set -l violet 6d71c4      # Parámetros
set -l magenta d23681     # Keywords

set -l selection 1a6397   # Selección

# =============================================================================
# Fish Shell - Syntax Highlighting Colors
# =============================================================================
set -g fish_color_normal $base0
set -g fish_color_command $cyan
set -g fish_color_keyword $magenta
set -g fish_color_quote $yellow
set -g fish_color_redirection $base0
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $violet
set -g fish_color_comment $base01
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $magenta
set -g fish_color_autosuggestion $base01
set -g fish_color_valid_path --underline
set -g fish_color_match --background=$selection
set -g fish_color_cancel -r

# Completion Pager Colors
set -g fish_pager_color_progress $base01
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $base0
set -g fish_pager_color_description $base01
set -g fish_pager_color_selected_background --background=$selection

# =============================================================================
# Tide Prompt - Theme Configuration
# =============================================================================

# Prompt character colors
set -g tide_character_color $cyan
set -g tide_character_color_failure $red

# PWD (current directory) colors
set -g tide_pwd_bg_color $base02
set -g tide_pwd_color_anchors $base1
set -g tide_pwd_color_dirs $base0
set -g tide_pwd_color_truncated_dirs $base01

# Git colors - Clean state
set -g tide_git_bg_color $blue
set -g tide_git_bg_color_unstable $yellow
set -g tide_git_bg_color_urgent $red
set -g tide_git_branch_color $base04
set -g tide_git_color_branch $base04
set -g tide_git_color_conflicted $base04
set -g tide_git_color_dirty $base04
set -g tide_git_color_operation $base04
set -g tide_git_color_staged $base04
set -g tide_git_color_stash $base04
set -g tide_git_color_untracked $base04
set -g tide_git_color_upstream $base04
set -g tide_git_conflicted_color $base04
set -g tide_git_dirty_color $base04
set -g tide_git_operation_color $base04
set -g tide_git_staged_color $base04
set -g tide_git_stash_color $base04
set -g tide_git_untracked_color $base04
set -g tide_git_upstream_color $base04

# Git icon (Nerd Font)
set -g tide_git_icon 

# Status colors
set -g tide_status_bg_color $base02
set -g tide_status_bg_color_failure $red
set -g tide_status_color $green
set -g tide_status_color_failure $base04

# Command duration
set -g tide_cmd_duration_bg_color $base02
set -g tide_cmd_duration_color $yellow

# Context (user@host)
set -g tide_context_bg_color $base02
set -g tide_context_color_default $yellow
set -g tide_context_color_root $orange
set -g tide_context_color_ssh $cyan

# Jobs indicator
set -g tide_jobs_bg_color $base02
set -g tide_jobs_color $cyan

# Time
set -g tide_time_bg_color $base02
set -g tide_time_color $base0

# Node.js
set -g tide_node_bg_color $green
set -g tide_node_color $base04

# Python
set -g tide_python_bg_color $blue
set -g tide_python_color $base04

# Ruby
set -g tide_ruby_bg_color $red
set -g tide_ruby_color $base04

# Rust
set -g tide_rust_bg_color $orange
set -g tide_rust_color $base04

# Go
set -g tide_go_bg_color $cyan
set -g tide_go_color $base04

# Docker
set -g tide_docker_bg_color $blue
set -g tide_docker_color $base04

# kubectl
set -g tide_kubectl_bg_color $violet
set -g tide_kubectl_color $base04

# AWS
set -g tide_aws_bg_color $orange
set -g tide_aws_color $base04

# Terraform
set -g tide_terraform_bg_color $violet
set -g tide_terraform_color $base04

# Virtual env
set -g tide_virtual_env_bg_color $cyan
set -g tide_virtual_env_color $base04

# Toolbox
set -g tide_toolbox_bg_color $violet
set -g tide_toolbox_color $base04

# Distrobox
set -g tide_distrobox_bg_color $magenta
set -g tide_distrobox_color $base04

# Nix shell
set -g tide_nix_shell_bg_color $blue
set -g tide_nix_shell_color $base04

# SHLVL (shell level)
set -g tide_shlvl_bg_color $base02
set -g tide_shlvl_color $yellow

# Private mode
set -g tide_private_mode_bg_color $violet
set -g tide_private_mode_color $base04

# OS icon
set -g tide_os_bg_color $base02
set -g tide_os_color $base0
