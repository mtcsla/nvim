-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  orange = "#fbb384",
  white  = '#c6c6c6',
  red    = '#f18aa8',
  violet = '#d183e8',
  grey   = '#383444',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.red },
    b = {  bg = colors.grey },
    c = { fg = colors.white },
    y = { fg = colors.white, bg = colors.grey },
    z = { fg = colors.grey, bg = colors.blue },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },

  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {"NvimTree"}
  },
  sections = {
    lualine_b = {  'filetype' },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = {'progress' },
    lualine_z = { "location" },
  },
  inactive_winbar = {
	  lualine_a = { 'filename' },
  },
  winbar = {
	  lualine_a = { 'filename' },
	  lualine_b = { {"navic", cond = require("nvim-navic").is_available } },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
