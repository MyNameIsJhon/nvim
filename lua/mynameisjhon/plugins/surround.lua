return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        ["("] = { add = { "(", ")" }, find = "%b()", delete = "^(.)().-(.)()$" },
        [")"] = { add = { "(", ")" }, find = "%b()", delete = "^(.)().-(.)()$" },

        ["{"] = { add = { "{", "}" }, find = "%b{}", delete = "^(.)().-(.)()$" },
        ["}"] = { add = { "{", "}" }, find = "%b{}", delete = "^(.)().-(.)()$" },

        ["["] = { add = { "[", "]" }, find = "%b[]", delete = "^(.)().-(.)()$" },
        ["]"] = { add = { "[", "]" }, find = "%b[]", delete = "^(.)().-(.)()$" },

        ["<"] = { add = { "<", ">" }, find = "%b<>", delete = "^(.)().-(.)()$" },
        [">"] = { add = { "<", ">" }, find = "%b<>", delete = "^(.)().-(.)()$" },
      },
    })
  end,
}

