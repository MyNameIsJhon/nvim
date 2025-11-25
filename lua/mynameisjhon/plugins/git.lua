return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gh", ":DiffviewFileHistory<CR>", desc = "Repo history" },
			{ "<leader>gf", ":DiffviewFileHistory %<CR>", desc = "File history" },
			{ "<leader>go", ":DiffviewOpen<CR>", desc = "Open diff" },
			{ "<leader>gx", ":DiffviewClose<CR>", desc = "Close diff" },
		},
		config = function()
			require("diffview").setup({})
		end,
	},
}
