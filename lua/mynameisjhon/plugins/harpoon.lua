-- ~/.config/nvim/lua/plugins/harpoon.lua
return {
	"ThePrimeagen/harpoon",
	lazy = false, -- charge Harpoon dès l'ouverture
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon").setup({})

		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		-- On purge les mappings natifs de Vim qui bloquaient
		pcall(vim.keymap.del, "n", "S")
		pcall(vim.keymap.del, "n", "D")

		-- nos mappings Harpoon
		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: ajouter fichier" })
		vim.keymap.set("n", "E", ui.toggle_quick_menu, { desc = "Harpoon: menu rapide" })
		vim.keymap.set("n", "S", function()
			ui.nav_prev()
		end, { desc = "Harpoon: fichier précédent" })
		vim.keymap.set("n", "D", function()
			ui.nav_next()
		end, { desc = "Harpoon: fichier suivant" })
	end,
}
