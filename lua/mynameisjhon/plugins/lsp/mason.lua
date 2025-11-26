return {
  "williamboman/mason.nvim",
  dependencies = {
	"williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "lua_ls",
        "pylsp",
        "clangd",
        "intelephense",
        "bashls",
        "sqlls",
        "ts_ls",  -- TypeScript/JavaScript (remplace tsserver)
      },
      automatic_installation = true,
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ["pylsp"] = function()
        lspconfig.pylsp.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.diagnostic.config({
              virtual_text = false,
              signs = true,
              update_in_insert = false,
            })
          end,
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  enabled = true,
                  ignore = {
                    "E501", "E302", "E305", "W191", "E303", "E261",
                    "W291", "W293", "W391",
                  },
                },
                pylint = { enabled = false },
                pyflakes = { enabled = false },
              },
              configurationSources = { "pycodestyle" },
            },
          },
        })
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              completion = { callSnippet = "Replace" },
            },
          },
        })
      end,

      ["clangd"] = function()
        lspconfig.clangd.setup({
          capabilities = capabilities,
          cmd = { "clangd", "--background-index", "--clang-tidy" },
        })
      end,

      ["bashls"] = function()
        lspconfig.bashls.setup({
          capabilities = capabilities,
        })
      end,

      ["html"] = function()
        lspconfig.html.setup({
          capabilities = capabilities,
        })
      end,

      ["cssls"] = function()
        lspconfig.cssls.setup({
          capabilities = capabilities,
        })
      end,

      ["intelephense"] = function()
        lspconfig.intelephense.setup({
          capabilities = capabilities,
          filetypes = { "php", "blade", "php.blade" },
        })
      end,

      ["sqlls"] = function()
        lspconfig.sqlls.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            print("SQL LSP attached on buffer " .. bufnr)
          end,
        })
      end,
    })
  end,
}
