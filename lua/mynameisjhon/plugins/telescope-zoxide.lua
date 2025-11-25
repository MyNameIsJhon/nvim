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
		require("telescope").load_extension("zoxide")
	end,
}
