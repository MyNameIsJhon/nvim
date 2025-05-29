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
				"bashls",
				"sqlls",
			},
		})

		-- Outils supplémentaires : linters, formatters, etc.
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- formatter JavaScript/TypeScript/JSON/etc
				"stylua", -- formatter Lua
				"isort", -- formatter Python
				"black", -- formatter Python
				"pylint", -- linter Python
				"eslint_d", -- linter JavaScript
			},
		})
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
						vim.lsp.handlers["textDocument/publishDiagnostics"] =
							vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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
										"E501",
										"E302",
										"E305",
										"W191",
										"E303",
										"E261",
										"W291",
										"W293",
										"W391",
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

			["intelephense"] = function()
				lspconfig.intelephense.setup({
					capabilities = capabilities,
					-- AJOUT : spécifier les filetypes
					filetypes = { "php", "blade", "php.blade" },
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
