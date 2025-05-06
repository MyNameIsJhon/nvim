-- plugins/copilot-cmp.lua
return {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua", "nvim-cmp" },
  config = function()
    require("copilot_cmp").setup({
      -- Méthode pour récupérer les suggestions (cycling ou getCompletions)
      method = "getCompletionsCycling",
      formatters = {
        -- Supprime les textes déjà insérés pour éviter les doublons
        insert_text = require("copilot_cmp.format").remove_existing,
      },
    })
  end,
}
