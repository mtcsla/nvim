require('lualine').setup {
    options = {
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'NvimTree' },
            winbar = { 'NvimTree' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {
        lualine_a = { 'filename' },
        lualine_b = {
            {
                'navic',
                cond = function() return true end,
                fmt = function(str)
                    if str == "" or str == nil then
                        return "   " -- Show consistent spacing when no breadcrumbs
                    end
                    return str
                end,
                color = { bg = 'none' }
            }
        },
        lualine_c = {},
        lualine_x = {
            {
                'datetime',
                style = '%H:%M'
            }
        },
        lualine_y = { 'searchcount' },
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'nvim-tree' }
}
