vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk"})
local opts = { noremap = true, silent = true }

-- increment/decrement numbers

keymap.set("n", "<leader>-", "<C-x>" , {desc = "Decrement number"})
keymap.set("n", "<leader>+", "<C-a>", {desc = "Increment number"})

-- window management

keymap.set("n", "<leader>sv", "<C-w>v", {desc = "split window vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc ="split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc= "make split equal sizes"})
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "close current split"})

-- window resizing (using leader + r for resize)
keymap.set("n", "<leader>rk", ":resize +2<CR>", {desc = "Increase window height"})
keymap.set("n", "<leader>rj", ":resize -2<CR>", {desc = "Decrease window height"})
keymap.set("n", "<leader>rh", ":vertical resize -2<CR>", {desc = "Decrease window width"})
keymap.set("n", "<leader>rl", ":vertical resize +2<CR>", {desc = "Increase window width"})

-- preset window sizes
keymap.set("n", "<leader>r=", "<C-w>=", {desc = "Equal window sizes (50/50)"})
keymap.set("n", "<leader>rm", "<C-w>_<C-w>|", {desc = "Maximize current window"})
keymap.set("n", "<leader>r7", function()
  vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.75))
end, {desc = "Set window to 75% width"})
keymap.set("n", "<leader>r6", function()
  vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.60))
end, {desc = "Set window to 60% width"})
keymap.set("n", "<leader>r3", function()
  vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.30))
end, {desc = "Set window to 30% width"})

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {desc = "Open new tab"})
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {desc= "Close current tab"})
keymap.set("n", "<leader>tm", "<cmd>tabn<CR>", {desc= "Go to next tab"})
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {desc= "Go to previous tab"})
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", {desc= "Open current buffer in new tab"})









--gen vim keybinds

vim.keymap.set({ 'n', 'v' }, '<leader>lm', ':Gen<CR>', {desc = "Gen AI"})
