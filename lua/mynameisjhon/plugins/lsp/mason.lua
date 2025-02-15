return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- On peut soit (1) dupliquer ensure_installed ici, soit (2) 
    -- se baser uniquement sur ce qui est défini dans ton lsp.lua.
    -- Tu peux choisir de fusionner ou non. Voici un exemple :
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "html",
        "cssls",
        "lua_ls",
        "pylsp",
        "clangd",
        "intelephense",
        "tsserver",
        "bashls",
        "sqlls",
        "asm_lsp",
        "makefile_ls",
      },
    })

    -- Outils supplémentaires : linters, formatters, etc.
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- formatter JavaScript/TypeScript/JSON/etc
        "stylua",   -- formatter Lua
        "isort",    -- formatter Python
        "black",    -- formatter Python
        "pylint",   -- linter Python
        "eslint_d", -- linter JavaScript
      },
    })
  end,
}
