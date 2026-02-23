-- Solarized Osaka colorscheme for Neovim
-- https://github.com/craftzdog/solarized-osaka.nvim
--
-- Plugin configuration for lazy.nvim

return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Enable transparency to match iTerm2 background
      transparent = true,

      -- Configure terminal colors (affects :terminal)
      terminal_colors = true,

      -- Style configuration
      styles = {
        -- Syntax styles
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},

        -- Background styles for sidebars and floating windows
        -- Options: "dark", "transparent", or "normal"
        sidebars = "dark",
        floats = "dark",
      },

      -- Set a darker background on sidebar-like windows
      sidebars = {
        "qf",          -- Quickfix
        "help",        -- Help
        "terminal",    -- Terminal
        "packer",      -- Packer
        "NvimTree",    -- NvimTree
        "neo-tree",    -- Neo-tree
        "Trouble",     -- Trouble
        "lazy",        -- Lazy
        "mason",       -- Mason
        "notify",      -- Notify
        "toggleterm",  -- ToggleTerm
        "lazyterm",    -- LazyTerm
      },

      -- Dims inactive windows
      dim_inactive = false,

      -- When true, section headers in lualine will be bold
      lualine_bold = true,

      -- Hide inactive statuslines (replace with thin border)
      hide_inactive_statusline = false,

      -- Optional: Override specific colors
      -- on_colors = function(colors)
      --   colors.hint = colors.orange
      -- end,

      -- Optional: Override specific highlights
      -- on_highlights = function(highlights, colors)
      --   highlights.LineNr = { fg = colors.base01 }
      -- end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd.colorscheme("solarized-osaka")
    end,
  },
}
