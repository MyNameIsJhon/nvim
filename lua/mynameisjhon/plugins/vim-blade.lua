return {
{
  "jwalton512/vim-blade",
  {
    "jwalton512/vim-blade",
    event = { "BufReadPost *.blade.php", "BufNewFile *.blade.php" },
    config = function()
      -- Force la détection si besoin
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = { "*.blade.php" },
        command = "set filetype=blade",
      })
    end,
  },
  event = { "BufReadPost *.blade.php", "BufNewFile *.blade.php" },
  config = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.blade.php" },
      command = "set filetype=blade",
    })
  end,
},
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Lazy détecte automatiquement si c'est un plugin "opts" ou "config"
    opts = {
      ensure_installed = {
        "php",
        "html",
        "css",
        "javascript",
        "json",
        "lua",
      },
      highlight = { enable = true },
    },
  },
}
