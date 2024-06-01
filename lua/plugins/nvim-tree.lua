local function on_attach(bufnr)
  local api = require "nvim-tree.api"
 
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>',         api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',             api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', '<leader>e',     api.tree.toggle)

  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#0e0f13" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg="#0a0a0e" })
end

require("nvim-tree").setup { 
	on_attach = on_attach,
	renderer = {
		root_folder_label = false
	},
	view = {
		hide_root_folder = true
	},
}


