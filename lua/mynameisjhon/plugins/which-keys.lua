

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")

    wk.setup({})

    -- Register group names
    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>s", group = "Split" },
      { "<leader>t", group = "Tab/Terminal" },
      { "<leader>e", group = "Explorer" },
      { "<leader>l", group = "AI/LSP" },
      { "<leader>o", group = "Open" },
      { "<leader>x", group = "Trouble" },
      { "<leader>w", group = "Workspace/Session" },
      { "<leader>m", group = "Mason/Format" },
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Rename" },
      { "<leader>a", group = "Harpoon" },
      { "<leader>z", group = "Zoxide" },
    })
  end,
}
