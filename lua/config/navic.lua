-- Setup nvim-navic plugin
require("nvim-navic").setup({
    icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬 ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
    },
    lsp = {
        auto_attach = true,
        preference = nil,
    },
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    lazy_update_context = false,
    click = false,
    format_text = function(text)
        return text
    end,
})

-- Set up highlight groups
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- Set highlights for NavicIcons
        vim.api.nvim_set_hl(0, 'NavicIconsFile', { default = true, fg = '#FFD700', bg = 'NONE' })          -- Gold color for files
        vim.api.nvim_set_hl(0, 'NavicIconsModule', { default = true, fg = '#FF4500', bg = 'NONE' })        -- Orange red for modules
        vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { default = true, fg = '#1E90FF', bg = 'NONE' })     -- Dodger blue for namespaces
        vim.api.nvim_set_hl(0, 'NavicIconsPackage', { default = true, fg = '#32CD32', bg = 'NONE' })       -- Lime green for packages
        vim.api.nvim_set_hl(0, 'NavicIconsClass', { default = true, fg = '#8A2BE2', bg = 'NONE' })         -- Blue violet for classes
        vim.api.nvim_set_hl(0, 'NavicIconsMethod', { default = true, fg = '#FF8C00', bg = 'NONE' })        -- Dark orange for methods
        vim.api.nvim_set_hl(0, 'NavicIconsProperty', { default = true, fg = '#ADFF2F', bg = 'NONE' })      -- Green yellow for properties
        vim.api.nvim_set_hl(0, 'NavicIconsField', { default = true, fg = '#FF1493', bg = 'NONE' })         -- Deep pink for fields
        vim.api.nvim_set_hl(0, 'NavicIconsConstructor', { default = true, fg = '#00BFFF', bg = 'NONE' })   -- Deep sky blue for constructors
        vim.api.nvim_set_hl(0, 'NavicIconsEnum', { default = true, fg = '#8B0000', bg = 'NONE' })          -- Dark red for enums
        vim.api.nvim_set_hl(0, 'NavicIconsInterface', { default = true, fg = '#FF00FF', bg = 'NONE' })     -- Magenta for interfaces
        vim.api.nvim_set_hl(0, 'NavicIconsFunction', { default = true, fg = '#7CFC00', bg = 'NONE' })      -- Lawn green for functions
        vim.api.nvim_set_hl(0, 'NavicIconsVariable', { default = true, fg = '#00FA9A', bg = 'NONE' })      -- Medium spring green for variables
        vim.api.nvim_set_hl(0, 'NavicIconsConstant', { default = true, fg = '#1E90FF', bg = 'NONE' })      -- Dodger blue for constants
        vim.api.nvim_set_hl(0, 'NavicIconsString', { default = true, fg = '#FF4500', bg = 'NONE' })        -- Orange red for strings
        vim.api.nvim_set_hl(0, 'NavicIconsNumber', { default = true, fg = '#FFD700', bg = 'NONE' })        -- Gold for numbers
        vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { default = true, fg = '#00FF00', bg = 'NONE' })       -- Lime for booleans
        vim.api.nvim_set_hl(0, 'NavicIconsArray', { default = true, fg = '#1E90FF', bg = 'NONE' })         -- Dodger blue for arrays
        vim.api.nvim_set_hl(0, 'NavicIconsObject', { default = true, fg = '#8A2BE2', bg = 'NONE' })        -- Blue violet for objects
        vim.api.nvim_set_hl(0, 'NavicIconsKey', { default = true, fg = '#FF4500', bg = 'NONE' })           -- Orange red for keys
        vim.api.nvim_set_hl(0, 'NavicIconsNull', { default = true, fg = '#FFD700', bg = 'NONE' })          -- Gold for null
        vim.api.nvim_set_hl(0, 'NavicIconsEnumMember', { default = true, fg = '#8B0000', bg = 'NONE' })    -- Dark red for enum members
        vim.api.nvim_set_hl(0, 'NavicIconsStruct', { default = true, fg = '#00BFFF', bg = 'NONE' })        -- Deep sky blue for structs
        vim.api.nvim_set_hl(0, 'NavicIconsEvent', { default = true, fg = '#FF00FF', bg = 'NONE' })         -- Magenta for events
        vim.api.nvim_set_hl(0, 'NavicIconsOperator', { default = true, fg = '#FF1493', bg = 'NONE' })      -- Deep pink for operators
        vim.api.nvim_set_hl(0, 'NavicIconsTypeParameter', { default = true, fg = '#7CFC00', bg = 'NONE' }) -- Lawn green for type parameters

        -- Set highlights for NavicText and NavicSeparator
        vim.api.nvim_set_hl(0, 'NavicText', { default = false, fg = '#ffffff', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'NavicSeparator', { default = true, fg = '#808080', bg = 'NONE' })
    end,
})

-- Set highlights immediately for current colorscheme
vim.api.nvim_set_hl(0, 'NavicText', { default = false, fg = '#ffffff', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NavicSeparator', { default = true, fg = '#808080', bg = 'NONE' })
