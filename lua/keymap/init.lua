vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>Q", vim.cmd.q)
vim.keymap.set("n", "<leader>q", function() vim.cmd "BufDel" end)


-- Diagnostic keymap moved to config/diagnostics.lua for consistency


vim.cmd "nnoremap <Tab> :bn<CR>"
vim.cmd "nnoremap <S-Tab> :bp<CR>"


vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<C-S>', ':w!<CR>', { noremap = true })

vim.keymap.set("n", "<leader>%", ":vs<CR>", { noremap = true })
vim.keymap.set("n", '<leader>"', ":sp<CR>", { noremap = true })
