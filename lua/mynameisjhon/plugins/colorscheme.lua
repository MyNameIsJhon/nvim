return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Couleurs avec un meilleur contraste et des éléments plus visibles
      local bg = "#0a0e14"
      local bg_dark = "#05080d"
      local bg_sidebar = "#1e2430"
      local bg_highlight = "#283347"
      local bg_search = "#3a5b7a"
      local bg_visual = "#324a6a"
      local fg = "#d1e6ff"
      local fg_dark = "#a0b4c8"
      local fg_sidebar = "#e2efff"
      local fg_gutter = "#4b6b85"
      local border = "#3b5a7a"

      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_sidebar = bg_sidebar
          colors.bg_statusline = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_sidebar
        end,
        on_highlights = function(hl, c)
          -- "Vert hacker" un peu adouci pour les commentaires
          hl.Comment = {
            fg = "#2b9b35", -- Ajuste selon ta préférence
            italic = true,
          }
        end,
      })

      -- Charge le thème
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
