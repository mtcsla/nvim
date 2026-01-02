return {
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            local metals = require("metals")
            local metals_config = metals.bare_config()

            metals_config.settings = {
                showImplicitArguments = true,
                excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            }

            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

            local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt", "java" },
                callback = function() metals.initialize_or_attach(metals_config) end,
                group = group,
            })
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
        ft = { "rust" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                    inlay_hints = {
                        auto = true,
                        only_current_line = false,
                        show_parameter_hints = true,
                        parameter_hints_prefix = "<- ",
                        other_hints_prefix = "=> ",
                    },
                },
                server = {
                    on_attach = function(client, bufnr)
                        -- Set up rust-specific keymaps
                        vim.keymap.set("n", "<leader>ca", function()
                            vim.cmd.RustLsp('codeAction')
                        end, { desc = "Code Action", buffer = bufnr })
                        vim.keymap.set("n", "<leader>dr", function()
                            vim.cmd.RustLsp('debuggables')
                        end, { desc = "Rust Debuggables", buffer = bufnr })
                        vim.keymap.set("n", "<leader>rr", function()
                            vim.cmd.RustLsp('runnables')
                        end, { desc = "Rust Runnables", buffer = bufnr })
                        vim.keymap.set("n", "<leader>rt", function()
                            vim.cmd.RustLsp('testables')
                        end, { desc = "Rust Testables", buffer = bufnr })
                    end,
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                        },
                    },
                },
                dap = {
                    adapter = {
                        type = "executable",
                        command = "lldb-vscode",
                        name = "rt_lldb",
                    },
                },
            }
        end,
    },

    {
        "saecki/crates.nvim",
        tag = "stable",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('crates').setup({
                text = {
                    loading = "   Loading",
                    version = "   %s",
                    prerelease = "   %s",
                    yanked = "   %s",
                    nomatch = "   No match",
                    upgrade = "   %s",
                    error = "   Error fetching crate",
                },
                highlight = {
                    loading = "CratesNvimLoading",
                    version = "CratesNvimVersion",
                    prerelease = "CratesNvimPreRelease",
                    yanked = "CratesNvimYanked",
                    nomatch = "CratesNvimNoMatch",
                    upgrade = "CratesNvimUpgrade",
                    error = "CratesNvimError",
                },
                popup = {
                    autofocus = true,
                    border = "rounded",
                    show_version_date = true,
                    show_dependency_version = true,
                    max_height = 30,
                    min_width = 20,
                    padding = 1,
                },
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            })
        end,
    },
    {
        "filipdutescu/renamer.nvim",
        branch = "master",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.renamer")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    -- JavaScript/TypeScript
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.diagnostics.trail_space,
                },
            })
        end,
    },
    "ojroques/nvim-bufdel",

    -- Code formatting
    "mhartington/formatter.nvim",

    -- Color scheme
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("lackluster-mint")
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        end,
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
                hide_cursor = true,
                stop_eof = true,
                respect_scrolloff = false,
                cursor_scrolls_alone = true,
                easing = "linear",
            })
        end,
    },
    "onsails/lspkind.nvim",


    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup({
                init = function()
                    require("hover.providers.lsp")
                    require('hover.providers.gh')
                    require('hover.providers.man')
                end,
                preview_opts = {
                    border = 'single'
                },
                preview_window = false,
                title = true,
            })

            -- Setup keymaps
            vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
            vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
            vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end,
                { desc = "hover.nvim (previous source)" })
            vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end,
                { desc = "hover.nvim (next source)" })

            -- Mouse support
            vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
            vim.o.mousemoveevent = true
        end,
    },
    {
        "chikko80/error-lens.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = function()
            require("colorful-winsep").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("config.lspconfig").setup()
        end,
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            require("config.navic")
        end,
    },
    "github/copilot.vim",

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
        config = function()
            require("config.lualine")
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            require("config.cmp")
        end,
    },

    -- Fuzzy finder
    {
        "nvim-lua/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.telescope")
        end,
    },

    -- Catppuccin theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("config.catppuccin")
        end,
    },

    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("config.treesitter")
        end,
    },

    -- Additional treesitter text objects for enhanced navigation
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -- Quick navigation
    "theprimeagen/harpoon",

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.nvim-tree")
        end,
    },

    -- Buffer line
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("config.bufferline")
        end,
    },
    "xiyaowong/transparent.nvim",
    {
        "mrjones2014/smart-splits.nvim",
        version = "v1.0.0",
        config = function()
            require("config.smart-splits")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                },
            })
        end,
    },
    "tpope/vim-fugitive",
}
