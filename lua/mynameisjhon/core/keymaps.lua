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

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {desc = "Open new tab"})
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {desc= "Close current tab"})
keymap.set("n", "<leader>tm", "<cmd>tabn<CR>", {desc= "Go to next tab"})
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {desc= "Go to previous tab"})
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", {desc= "Open current buffer in new tab"})









--gen vim keybinds

vim.keymap.set({ 'n', 'v' }, '<leader>lm', ':Gen<CR>', {desc = "Gen AI"})
