require("telescope").setup()

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})

vim.keymap.set('n', '<leader>gf', builtin.git_files, {})

vim.keymap.set('n', '<leader>gst', builtin.git_status, {})
vim.keymap.set('n', '<leader>gsh', builtin.git_stash, {})
vim.keymap.set('n', '<leader>gbr', builtin.git_branches, {})

vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})

-- something is overriding the highlight groups later, so this needs to be deferred a second or few
vim.defer_fn(function()
	local colors = {
	  white = "#D9E0EE",
	  darker_black = "#0a0a0e",
	  black = "#0a0a0e", --  nvim bg
	  black2 = "#252434",
	  one_bg = "#0a0a0e", -- real bg of onedark
	  one_bg2 = "#363545",
	  one_bg3 = "#3e3d4d",
	  grey = "#474656",
	  grey_fg = "#4e4d5d",
	  grey_fg2 = "#555464",
	  light_grey = "#60#1E1D2D5f6f",
	  red = "#F38BA8",
	  baby_pink = "#ffa5c3",
	  pink = "#F5C2E7",
	  line = "#383747", -- for lines like vertsplit
	  green = "#ABE9B3",
	  vibrant_green = "#b6f4be",
	  nord_blue = "#8bc2f0",
	  blue = "#89B4FA",
	  yellow = "#FAE3B0",
	  sun = "#ffe9b6",
	  purple = "#d0a9e5",
	  dark_purple = "#c7a0dc",
	  teal = "#B5E8E0",
	  orange = "#F8BD96",
	  cyan = "#89DCEB",
	  statusline_bg = "#232232",
	  lightbg = "#2f2e3e",
	  pmenu_bg = "#ABE9B3",
	  folder_bg = "#89B4FA",
	  lavender = "#c7d1ff",
	}

	local hlgroups = {

	  TelescopePromptPrefix = {
	    fg = colors.red,
	    bg = colors.black2,
	  },

	  TelescopeNormal = { bg = colors.darker_black },

	  TelescopePreviewTitle = {
	    fg = colors.black,
	    bg = colors.green,
	  },

	  TelescopePromptTitle = {
	    fg = colors.black,
	    bg = colors.red,
	  },

	  TelescopeSelection = { bg = colors.black2, fg = colors.white },
	  TelescopeResultsDiffAdd = { fg = colors.green },
	  TelescopeResultsDiffChange = { fg = colors.yellow },
	  TelescopeResultsDiffDelete = { fg = colors.red },

	  TelescopeMatching = { bg = colors.one_bg, fg = colors.blue },
	}

	local styles = {
	  borderless = {
	    TelescopeBorder = { fg = colors.darker_black, bg = colors.darker_black },
	    TelescopePromptBorder = { fg = colors.black2, bg = colors.black2 },
	    TelescopePromptNormal = { fg = colors.white, bg = colors.black2 },
	    TelescopeResultsTitle = { fg = colors.darker_black, bg = colors.darker_black },
	    TelescopePromptPrefix = { fg = colors.red, bg = colors.black2 },
	  },

	  bordered = {
	    TelescopeBorder = { fg = colors.one_bg3 },
	    TelescopePromptBorder = { fg = colors.one_bg3 },
	    TelescopeResultsTitle = { fg = colors.black, bg = colors.green },
	    TelescopePreviewTitle = { fg = colors.black, bg = colors.blue },
	    TelescopePromptPrefix = { fg = colors.red, bg = colors.black },
	    TelescopeNormal = { bg = colors.black },
	    TelescopePromptNormal = { bg = colors.black },
	  },
	}

	local result = vim.tbl_deep_extend("force", hlgroups, styles.borderless)
	for key, val in pairs(result) do
	  vim.api.nvim_set_hl(0, key, val)
	end
end, 1000)
