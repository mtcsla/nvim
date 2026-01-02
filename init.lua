require("keymap")
require("highlights")
require("config.diagnostics")

-- Colors function for theme switching
function Colors(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NonText", { fg = "black" })
end

vim.opt.fillchars = { eob = " " }
vim.cmd "set number"
vim.cmd "set cmdheight=0"
vim.cmd "set signcolumn=yes"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    ui = { border = "rounded" },
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.cmd "set nowrap"
    end,
})


vim.cmd "set expandtab"
vim.cmd "set shiftwidth=4"
