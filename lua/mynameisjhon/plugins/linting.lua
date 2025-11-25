return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Configuration du linter norminette pour la norme 42
    lint.linters.norminette = {
      cmd = "norminette",
      stdin = false,
      args = {},
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local lines = vim.split(output, "\n")

        for _, line in ipairs(lines) do
          -- Format: Error: ERROR_NAME    (line: XX, col: YY):	message
          -- Avec possibles codes couleur ANSI: [94m, [0m, etc.

          -- Supprimer les codes couleur ANSI
          local clean_line = line:gsub("%[%d+m", "")

          -- Parser le format de norminette
          local error_type, lnum, col, message = clean_line:match("Error:%s*(%S+)%s*%(line:%s*(%d+),%s*col:%s*(%d+)%):%s*(.*)$")

          if lnum and message then
            -- Nettoyer le message (enlever les tabs au début)
            message = message:gsub("^%s+", "")

            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,  -- nvim utilise 0-indexed
              col = tonumber(col) - 1,
              end_lnum = tonumber(lnum) - 1,
              end_col = tonumber(col),
              severity = vim.diagnostic.severity.ERROR,
              source = "norminette",
              message = string.format("[%s] %s", error_type, message),
              code = error_type,
            })
          end
        end

        return diagnostics
      end,
    }

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      c = { "norminette" },
      h = { "norminette" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Linting automatique désactivé pour C/H (lancement manuel uniquement)
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        if ft ~= "c" and ft ~= "h" then
          lint.try_lint()
        end
      end,
    })

    -- Linting manuel pour tous les fichiers
    vim.keymap.set("n", "<leader>lt", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })

    -- Keybind spécial pour norminette (norme 42)
    vim.keymap.set("n", "<leader>ln", function()
      local ft = vim.bo.filetype
      if ft == "c" or ft == "h" then
        lint.try_lint("norminette")
        -- Attendre un peu que les diagnostics soient chargés puis afficher
        vim.defer_fn(function()
          local diag_count = #vim.diagnostic.get(0, { source = "norminette" })
          if diag_count > 0 then
            vim.notify(string.format("Norminette: %d erreur(s) trouvée(s)", diag_count), vim.log.levels.WARN)
            -- Ouvrir automatiquement la liste des diagnostics
            vim.cmd("Trouble diagnostics filter.buf=0")
          else
            vim.notify("Norminette: OK! ✓", vim.log.levels.INFO)
          end
        end, 200)
      else
        vim.notify("Norminette est uniquement pour les fichiers C/H", vim.log.levels.WARN)
      end
    end, { desc = "Run norminette (42)" })
  end,
}
