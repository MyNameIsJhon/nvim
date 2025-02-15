return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    -- Gère le rename/déplacement de fichiers (ne concerne pas le rename de symboles)
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Optionnel, pour du meilleur support Lua / Neovim
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Import LSP-related plugins
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Keybindings LSP communs
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Autocompletion capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- IMPORTANT: Assure-toi que Mason installe ces serveurs-là (voir mason.lua plus bas)
    mason_lspconfig.setup({
      -- Tu peux adapter la liste ci-dessous. 
      -- On y ajoute notamment tsserver, bashls, html, cssls, intelephense, sqls et asm-lsp.
      ensure_installed = {
        "clangd",       -- C/C++
        "pylsp",        -- Python
        "lua_ls",       -- Lua (Neovim config)
        "makefile_ls",  -- Makefiles
        "tsserver",     -- JavaScript / TypeScript
        "bashls",       -- Bash
        "html",         -- HTML
        "cssls",        -- CSS
        "intelephense", -- PHP
        "sqlls",        -- SQL (MySQL, PostgreSQL, etc.)
        "asm_lsp",      -- Assembleur (expérimental, si ça existe via Mason)
      },
    })

    -- Setup handlers par serveur
    mason_lspconfig.setup_handlers({
      -- Par défaut, pour tous les serveurs non listés ci-dessous
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- Python
      ["pylsp"] = function()
        lspconfig.pylsp.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Exemple: désactiver le virtual_text en Python, si tu le souhaites
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics,
              {
                virtual_text = false,
                signs = true,
                update_in_insert = false,
              }
            )
          end,
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  enabled = true,
                  ignore = {
                    "E501", "E302", "E305", "W191", "E303", "E261", "W291", "W293", "W391"
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

      -- Lua
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,

      -- C/C++ (Clangd)
      ["clangd"] = function()
        lspconfig.clangd.setup({
          capabilities = capabilities,
          cmd = { "clangd", "--background-index", "--clang-tidy" },
        })
      end,

      -- Makefile
      ["makefile_ls"] = function()
        lspconfig.makefile_ls.setup({
          capabilities = capabilities,
          filetypes = { "make" },
          on_attach = function(client, bufnr)
            print("Makefile LSP attached on buffer " .. bufnr)
          end,
        })
      end,

      -- Assembleur (asm-lsp) - si installé
      ["asm_lsp"] = function()
        lspconfig.asm_lsp.setup({
          capabilities = capabilities,
          filetypes = { "asm", "nasm", "s" },  -- adapte selon tes besoins
          on_attach = function(client, bufnr)
            print("ASM LSP attached on buffer " .. bufnr)
          end,
        })
      end,

      -- JavaScript / TypeScript
      ["tsserver"] = function()
        lspconfig.tsserver.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- exemple : tu peux désactiver le format intégré de tsserver 
            -- si tu préfères utiliser prettier ou eslint pour formatter
            client.server_capabilities.documentFormattingProvider = false
          end,
        })
      end,

      -- Bash
      ["bashls"] = function()
        lspconfig.bashls.setup({
          capabilities = capabilities,
        })
      end,

      -- HTML
      ["html"] = function()
        lspconfig.html.setup({
          capabilities = capabilities,
        })
      end,

      -- CSS
      ["cssls"] = function()
        lspconfig.cssls.setup({
          capabilities = capabilities,
        })
      end,

      -- PHP
      ["intelephense"] = function()
        lspconfig.intelephense.setup({
          capabilities = capabilities,
        })
      end,

      -- SQL
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
