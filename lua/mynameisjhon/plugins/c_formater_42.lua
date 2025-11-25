return {
	"cacharle/c_formatter_42.vim",
	ft = { "c", "h" }, -- charge uniquement pour les fichiers C et headers
	config = function()
		-- Raccourci F2 pour formatter avec la norme 42
		vim.keymap.set("n", "<F2>", ":CFormatter42<CR>", { desc = "Format 42 (C)" })
	end,
}
