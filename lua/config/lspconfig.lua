-- Modern LSP configuration using vim.lsp.config for Neovim 0.11+
local function setup()
    -- Configure LSP hover to remove borders and match cmp background
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "none",
        winhighlight = "Normal:CmpPmenu"
    })

    -- Configure signature help to match cmp popup styling
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "none",
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu"
    })

    -- Get the default capabilities from nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local function on_attach(client, bufnr)
        -- Attach navic for breadcrumb navigation
        local navic_ok, navic = pcall(require, "nvim-navic")
        if navic_ok then
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
                print("Navic attached to " .. client.name .. " for buffer " .. bufnr)
            else
                print("Client " .. client.name .. " does not support documentSymbolProvider")
            end
        else
            print("Failed to load nvim-navic: " .. tostring(navic))
        end

        -- Set up error lens (disabled by default)
        pcall(function()
            require("error-lens").setup(client, {
                enabled = false
            })
        end)

        -- Enhanced LSP keymaps
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Navigation
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = "Go to definition" }))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = "Go to declaration" }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = "Show references" }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
            vim.tbl_extend('force', opts, { desc = "Go to implementation" }))
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition,
            vim.tbl_extend('force', opts, { desc = "Go to type definition" }))

        -- Code actions and refactoring
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
            vim.tbl_extend('force', opts, { desc = "Code action" }))
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Rename symbol" }))

        -- Documentation
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = "Show hover info" }))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
            vim.tbl_extend('force', opts, { desc = "Signature help" }))

        -- Workspace
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
            vim.tbl_extend('force', opts, { desc = "Add workspace folder" }))
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
            vim.tbl_extend('force', opts, { desc = "Remove workspace folder" }))
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend('force', opts, { desc = "List workspace folders" }))

        -- Formatting
        if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format({ async = true })
            end, vim.tbl_extend('force', opts, { desc = "Format buffer" }))
        end

        -- Enable inlay hints if supported
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- Set up document highlight if supported
        if client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_augroup })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end

    -- Use the new vim.lsp.config API if available, fallback to lspconfig
    if vim.lsp.config then
        -- Modern vim.lsp.config approach

        -- Rust Analyzer
        vim.lsp.config.rust_analyzer = {
            cmd = { 'rust-analyzer' },
            filetypes = { 'rust' },
            root_markers = { 'Cargo.toml', 'rust-project.json' },
            settings = {
                ['rust-analyzer'] = {
                    -- Enable real-time diagnostics
                    checkOnSave = false,
                    check = {
                        enable = true,
                        command = "check",
                        allTargets = true,
                        workspace = false,
                    },
                    diagnostics = {
                        enable = true,
                        refreshSupport = true,
                        experimental = {
                            enable = true,
                        },
                    },
                    -- Cargo settings
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Procedural macros
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                    -- Rust formatting
                    rustfmt = {
                        extraArgs = { "+nightly" },
                    },
                    -- Completion settings
                    completion = {
                        callable = {
                            snippets = "fill_arguments",
                        },
                    },
                    -- Inlay hints
                    inlayHints = {
                        bindingModeHints = {
                            enable = false,
                        },
                        chainingHints = {
                            enable = true,
                        },
                        closingBraceHints = {
                            enable = true,
                            minLines = 25,
                        },
                        closureReturnTypeHints = {
                            enable = "never",
                        },
                        lifetimeElisionHints = {
                            enable = "never",
                            useParameterNames = false,
                        },
                        maxLength = 25,
                        parameterHints = {
                            enable = true,
                        },
                        reborrowHints = {
                            enable = "never",
                        },
                        renderColons = true,
                        typeHints = {
                            enable = true,
                            hideClosureInitialization = false,
                            hideNamedConstructor = false,
                        },
                    },
                    -- Lens settings
                    lens = {
                        enable = true,
                    },
                    -- Hover actions
                    hover = {
                        actions = {
                            enable = true,
                        },
                    },
                    -- Semantic tokens
                    semanticHighlighting = {
                        strings = {
                            enable = true,
                        },
                    },
                    -- Server settings
                    server = {
                        extraEnv = {
                            RUST_LOG = "error",
                        },
                    },
                },
            },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                -- Enable inlay hints if supported
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                -- Rust-specific keymaps
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "<leader>rr", function()
                    vim.cmd.RustLsp('run')
                end, vim.tbl_extend("force", opts, { desc = "Run Rust project" }))

                vim.keymap.set("n", "<leader>rt", function()
                    vim.cmd.RustLsp('testables')
                end, vim.tbl_extend("force", opts, { desc = "Run Rust tests" }))

                vim.keymap.set("n", "<leader>rd", function()
                    vim.cmd.RustLsp('debuggables')
                end, vim.tbl_extend("force", opts, { desc = "Debug Rust" }))

                vim.keymap.set("n", "<leader>ra", function()
                    vim.cmd.RustLsp('codeAction')
                end, vim.tbl_extend("force", opts, { desc = "Rust code actions" }))

                vim.keymap.set("n", "<leader>re", function()
                    vim.cmd.RustLsp('explainError')
                end, vim.tbl_extend("force", opts, { desc = "Explain Rust error" }))

                vim.keymap.set("n", "<leader>rc", function()
                    vim.cmd.RustLsp('openCargo')
                end, vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))

                vim.keymap.set("n", "<leader>rp", function()
                    vim.cmd.RustLsp('parentModule')
                end, vim.tbl_extend("force", opts, { desc = "Go to parent module" }))

                vim.keymap.set("n", "<leader>rj", function()
                    vim.cmd.RustLsp('joinLines')
                end, vim.tbl_extend("force", opts, { desc = "Join lines" }))

                vim.keymap.set("n", "<leader>rh", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
            end,
        }

        -- Go Language Server
        vim.lsp.config.gopls = {
            cmd = { 'gopls' },
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_markers = { 'go.work', 'go.mod', '.git' },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- TypeScript/JavaScript Language Server
        vim.lsp.config.ts_ls = {
            cmd = { 'typescript-language-server', '--stdio' },
            filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
            root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
            settings = {
                typescript = {
                    preferences = {
                        includeCompletionsForModuleExports = true,
                        includeCompletionsWithInsertText = true,
                    },
                    suggest = {
                        includeCompletionsForModuleExports = true,
                    },
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    preferences = {
                        includeCompletionsForModuleExports = true,
                        includeCompletionsWithInsertText = true,
                    },
                    suggest = {
                        includeCompletionsForModuleExports = true,
                    },
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                }
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- Lua Language Server
        vim.lsp.config.lua_ls = {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- Python Language Server
        vim.lsp.config.pyright = {
            cmd = { 'pyright-langserver', '--stdio' },
            filetypes = { 'python' },
            root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = 'openFilesOnly',
                        typeCheckingMode = 'basic',
                        autoImportCompletions = true,
                        diagnosticSeverityOverrides = {
                            reportUnusedImport = 'information',
                            reportUnusedVariable = 'information',
                            reportDuplicateImport = 'warning',
                        },
                    },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- SQL Language Server
        vim.lsp.config.sqlls = {
            cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
            filetypes = { 'sql', 'mysql' },
            root_markers = { '.git' },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- Tailwind CSS
        vim.lsp.config.tailwindcss = {
            cmd = { 'tailwindcss-language-server', '--stdio' },
            filetypes = { 'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ' },
            root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', '.git' },
            settings = {
                tailwindCSS = {
                    experimental = {
                        classRegex = {
                            "tw`([^`]*)",
                            "tw=\"([^\"]*)",
                            "tw={\"([^\"}]*)",
                            "tw\\.\\w+`([^`]*)",
                            "tw\\(.*?\\)`([^`]*)",
                        },
                    },
                },
            },
            capabilities = capabilities,
        }
    else
        -- Fallback to old lspconfig for older Neovim versions
        local lspconfig = require('lspconfig')

        -- Rust Analyzer
        lspconfig.rust_analyzer.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                -- Enable inlay hints if supported
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                -- Rust-specific keymaps
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "<leader>rh", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
            end,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    -- Enable real-time diagnostics
                    checkOnSave = false,
                    check = {
                        enable = true,
                        command = "check",
                        allTargets = true,
                        workspace = false,
                    },
                    diagnostics = {
                        enable = true,
                        refreshSupport = true,
                        experimental = {
                            enable = true,
                        },
                    },
                    -- Cargo settings
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Procedural macros
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                    -- Rust formatting
                    rustfmt = {
                        extraArgs = { "+nightly" },
                    },
                    -- Completion settings
                    completion = {
                        callable = {
                            snippets = "fill_arguments",
                        },
                    },
                    -- Inlay hints
                    inlayHints = {
                        bindingModeHints = {
                            enable = false,
                        },
                        chainingHints = {
                            enable = true,
                        },
                        closingBraceHints = {
                            enable = true,
                            minLines = 25,
                        },
                        closureReturnTypeHints = {
                            enable = "never",
                        },
                        lifetimeElisionHints = {
                            enable = "never",
                            useParameterNames = false,
                        },
                        maxLength = 25,
                        parameterHints = {
                            enable = true,
                        },
                        reborrowHints = {
                            enable = "never",
                        },
                        renderColons = true,
                        typeHints = {
                            enable = true,
                            hideClosureInitialization = false,
                            hideNamedConstructor = false,
                        },
                    },
                    -- Lens settings
                    lens = {
                        enable = true,
                    },
                    -- Hover actions
                    hover = {
                        actions = {
                            enable = true,
                        },
                    },
                    -- Semantic tokens
                    semanticHighlighting = {
                        strings = {
                            enable = true,
                        },
                    },
                    -- Server settings
                    server = {
                        extraEnv = {
                            RUST_LOG = "error",
                        },
                    },
                },
            },
        })

        -- Go Language Server
        lspconfig.gopls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })

        -- Tailwind CSS
        lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            settings = {
                tailwindCSS = {
                    experimental = {
                        classRegex = {
                            "tw`([^`]*)",
                            "tw=\"([^\"]*)",
                            "tw={\"([^\"}]*)",
                            "tw\\.\\w+`([^`]*)",
                            "tw\\(.*?\\)`([^`]*)",
                        },
                    },
                },
            },
        })

        -- TypeScript/JavaScript Language Server (using ts_ls instead of deprecated tsserver)
        lspconfig.ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                typescript = {
                    preferences = {
                        includeCompletionsForModuleExports = true,
                        includeCompletionsWithInsertText = true,
                    },
                    suggest = {
                        includeCompletionsForModuleExports = true,
                    },
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    preferences = {
                        includeCompletionsForModuleExports = true,
                        includeCompletionsWithInsertText = true,
                    },
                    suggest = {
                        includeCompletionsForModuleExports = true,
                    },
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                }
            }
        })

        -- SQL Language Server
        lspconfig.sqlls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- Lua Language Server
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library"
                        }
                    }
                })
            end,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            }
        })

        -- Python Language Server
        lspconfig.pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            on_new_config = function(config, root_dir)
                local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
                if string.len(env) > 0 then
                    config.settings.python.pythonPath = env .. '/bin/python'
                end
            end,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = 'openFilesOnly',
                        typeCheckingMode = 'basic',
                        autoImportCompletions = true,
                        diagnosticSeverityOverrides = {
                            reportUnusedImport = 'information',
                            reportUnusedVariable = 'information',
                            reportDuplicateImport = 'warning',
                        },
                    },
                },
            },
        })
    end
end

return { setup = setup }
