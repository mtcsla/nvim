require("catppuccin").setup({
	term_colors = true,
	flavour = "mocha",
	transparent_background = true,
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		mocha = {
			--base = "#000000",
			--mantle = "#000000",
			--crust = "#000000",
		},
	},
	integrations = {
		dropbar = {
			enabled = true,
			color_mode = true,
		},
		navic = {
		  enabled = true,
		  custom_bg = "NONE",
		},
	},
})
vim.cmd.colorscheme 'catppuccin'
