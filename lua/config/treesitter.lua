require 'nvim-treesitter.configs'.setup {
    -- Enhanced parser list with Rust-specific support
    ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "python", "typescript", "javascript",
        "rust", "toml", "json", "yaml", "markdown", "markdown_inline",
        "bash", "fish", "html", "css"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing
    ignore_install = {},

    highlight = {
        enable = true,

        -- Disable for large files to improve performance
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
            return false
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
    },

    -- Enhanced incremental selection for Rust
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<M-space>",
        },
    },

    -- Smart indentation
    indent = {
        enable = true,
        disable = { "python", "yaml" }, -- These languages have better indentation rules
    },

    -- Text objects for better navigation
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
}
