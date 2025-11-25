-- lua/mynameisjhon/plugins/aider.lua
-- Plugin : joshuavial/aider.nvim
-- On ouvre Aider avec les variables d'env + modèle Ollama, via AiderOpen "..."
return {
	"joshuavial/aider.nvim",
	keys = {
		{
			"<leader>ll",
			function()
				vim.cmd('AiderOpen "env OLLAMA_API_BASE=http://127.0.0.1:11434 AIDER_MODEL=ollama/qwen2.5-coder:7b aider --model ollama/qwen2.5-coder:7b" vsplit')
			end,
			desc = "Aider (Ollama)",
		},
		{ "<leader>om", "<cmd>AiderAddModifiedFiles<CR>", desc = "Aider: add modified files" },
	},
	opts = {
		-- tu peux désactiver les bindings par défaut si tu veux garder tes touches propres
		default_bindings = false,
		auto_manage_context = true,
	},
}
