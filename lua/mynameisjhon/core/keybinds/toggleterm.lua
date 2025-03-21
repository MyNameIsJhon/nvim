local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Terminal keymaps for toggleterm
keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- Apply terminal keymaps only to toggleterm instances
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "<esc>", [[<C-\\><C-n>]], { buffer = 0 })')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "jk", [[<C-\\><C-n>]], { buffer = 0 })')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.keymap.set("t", "<C-w>", [[<C-\\><C-n><C-w>]], { buffer = 0 })')

-- Keybindings for opening terminals in different layouts
keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', opts)
keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', opts)
keymap.set('n', '<leader>tt', ':ToggleTerm direction=float<CR>', opts)
-- En mode terminal, passer en mode normal puis fermer le buffer
vim.keymap.set('t', '<leader>tkx', [[<C-\><C-n>:bd!<CR>]], { noremap = true, silent = true })
