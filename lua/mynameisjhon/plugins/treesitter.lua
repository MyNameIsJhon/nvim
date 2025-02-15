return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "python",
        "cpp",
        "php",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-CR>",
          node_incremental = "<C-CR>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- configure nvim-ts-autotag separately
    require('nvim-ts-autotag').setup()
  end,
}
