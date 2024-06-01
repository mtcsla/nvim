vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>Q", vim.cmd.q)
vim.keymap.set("n", "<leader>q", function() vim.cmd "BufDel" end)

vim.cmd "nnoremap K :lua vim.lsp.buf.hover()<CR>"
vim.keymap.set('n', '<C-]>', ':bn<CR>', { noremap = true })
vim.keymap.set('n', '<C-[>', ':bp<CR>', { noremap = true })
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<C-S>', ':w!<CR>', { noremap = true })

vim.keymap.set("n", "<leader>%", ":vs<CR>", {noremap = true})
vim.keymap.set("n", '<leader>"', ":sp<CR>", {noremap = true})

-- set highlight NormalFloat
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
