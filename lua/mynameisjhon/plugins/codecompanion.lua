return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = { adapter = "ollama" },
			inline = { adapter = "ollama" },
		},
		adapters = {
			http = {
				ollama = function()
					local adapters = require("codecompanion.adapters")
					return adapters.extend("ollama", {
						env = { url = vim.env.OLLAMA_HOST or "http://127.0.0.1:11434" },
						schema = {
							model = { default = "qwen2.5-coder:7b" },
							num_ctx = { default = 8192 },
						},
						opts = { stream = true },
						parameters = { temperature = 0.2 },
					})
				end,
			},
		},
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)

		-- KEYBINDS — uniquement des commandes documentées par le plugin. :contentReference[oaicite:3]{index=3}
		-- Chat (ouvre/ferme le chat buffer)
		vim.keymap.set({ "n" }, "<leader>lc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "AI Chat (Ollama)" })

		-- Inline : en Normal/Visuel (si visuel, la sélection est envoyée en contexte)
		vim.keymap.set({ "n", "v" }, "<leader>li", "<cmd>CodeCompanion<CR>", { desc = "AI Inline (Ollama)" })

		-- Inline sur tout le fichier courant (sélectionne tout puis lance l'inline)
		vim.keymap.set("n", "<leader>lA", function()
			vim.cmd("keepjumps normal! ggVG")
			vim.cmd("CodeCompanion")
		end, { desc = "AI Inline sur tout le fichier" })

		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<CR>", { desc = "Chat: ajouter la sélection" })
	end,
}
