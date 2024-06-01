vim.defer_fn(
	function()
		vim.cmd "hi NormalFloat guibg=#0e0f13"
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#0e0f13" })
	end,
	2000
)
