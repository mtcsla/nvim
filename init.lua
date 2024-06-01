require("plugins.colors")
require("keymap")
require("plugins")
require("highlights")

vim.opt.fillchars = { eob = " " }
vim.cmd "set number"
vim.cmd "set cmdheight=0"
vim.cmd "set signcolumn=yes"

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.cmd "set nowrap"
	end,
})

