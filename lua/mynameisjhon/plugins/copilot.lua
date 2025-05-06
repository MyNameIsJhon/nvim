-- plugins/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    panel = { enabled = false },
    suggestion = {
      enabled      = false,  -- on laisse cmp gérer
      auto_trigger = false,
    },
    -- active partout :
    filetypes = {
      ["*"] = true,
    },
  },
}
