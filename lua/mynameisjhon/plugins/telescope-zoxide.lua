return {
	"jvgrootveld/telescope-zoxide",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{
			"<leader>z",
			function()
				require("telescope").extensions.zoxide.list()
			end,
			desc = "Telescope Zoxide",
		},
	},
	config = function()
		local telescope = require("telescope")
		local z_utils = require("telescope._extensions.zoxide.utils")

		telescope.setup({
			extensions = {
				zoxide = {
					prompt_title = "[ Zoxide List ]",
					mappings = {
						default = {
							after_action = function(selection)
								-- Change le répertoire de travail de Neovim
								vim.cmd("cd " .. selection.path)

								-- Rafraîchit nvim-tree si il est ouvert
								local nvim_tree_api = require("nvim-tree.api")
								if nvim_tree_api.tree.is_visible() then
									nvim_tree_api.tree.change_root(selection.path)
								end

								print("Changed directory to: " .. selection.path)
							end,
						},
						["<C-s>"] = {
							before_action = function(selection)
								print("before C-s")
							end,
							action = function(selection)
								vim.cmd("split")
								vim.cmd("cd " .. selection.path)
							end,
						},
						["<C-v>"] = {
							action = function(selection)
								vim.cmd("vsplit")
								vim.cmd("cd " .. selection.path)
							end,
						},
						["<C-t>"] = {
							action = function(selection)
								vim.cmd("tabnew")
								vim.cmd("tcd " .. selection.path)
							end,
						},
					},
				},
			},
		})

		telescope.load_extension("zoxide")
	end,
}
