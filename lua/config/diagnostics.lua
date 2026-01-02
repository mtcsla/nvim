-- Diagnostic configuration for inline diagnostics and enhanced error display
local M = {}

function M.setup()
    -- Configure diagnostic display
    vim.diagnostic.config({
        virtual_text = {
            enabled = true,
            source = "if_many",
            spacing = 4,
            prefix = "●",
            format = function(diagnostic)
                local message = diagnostic.message
                -- Truncate very long messages
                if string.len(message) > 80 then
                    message = string.sub(message, 1, 77) .. "..."
                end
                return message
            end,
        },
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "󰌶" },
                { name = "DiagnosticSignInfo", text = "" },
            },
        },
        underline = {
            enable = true,
            severity = { min = vim.diagnostic.severity.WARN },
        },
        update_in_insert = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "if_many",
            header = "",
            prefix = "",
            format = function(diagnostic)
                local code = diagnostic.code or
                    diagnostic.user_data and diagnostic.user_data.lsp and diagnostic.user_data.lsp.code
                if code then
                    return string.format("%s [%s]", diagnostic.message, code)
                end
                return diagnostic.message
            end,
        },
    })

    -- Define diagnostic signs
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "󰌶" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    -- Set up diagnostic highlight groups
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
        fg = "#f38ba8",
        bg = "NONE",
        italic = true,
        blend = 10
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
        fg = "#f9e2af",
        bg = "NONE",
        italic = true,
        blend = 10
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
        fg = "#89b4fa",
        bg = "NONE",
        italic = true,
        blend = 10
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {
        fg = "#94e2d5",
        bg = "NONE",
        italic = true,
        blend = 10
    })

    -- Error sign highlights
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#f38ba8" })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f9e2af" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#94e2d5" })

    -- Underline highlights
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
        undercurl = true,
        sp = "#f38ba8"
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
        undercurl = true,
        sp = "#f9e2af"
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
        undercurl = true,
        sp = "#89b4fa"
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
        undercurl = true,
        sp = "#94e2d5"
    })

    -- Set up diagnostic keymaps
    local opts = { noremap = true, silent = true }

    -- Navigate diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
        vim.tbl_extend('force', opts, { desc = "Go to previous diagnostic" }))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
        vim.tbl_extend('force', opts, { desc = "Go to next diagnostic" }))

    -- Show diagnostics
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float,
        vim.tbl_extend('force', opts, { desc = "Show line diagnostics" }))
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist,
        vim.tbl_extend('force', opts, { desc = "Show buffer diagnostics in location list" }))
    vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist,
        vim.tbl_extend('force', opts, { desc = "Show all diagnostics in quickfix" }))

    -- Toggle diagnostics
    vim.keymap.set('n', '<leader>dd', function()
        if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
            print("Diagnostics enabled")
        else
            vim.diagnostic.disable()
            print("Diagnostics disabled")
        end
    end, vim.tbl_extend('force', opts, { desc = "Toggle diagnostics" }))

    -- Toggle virtual text
    local virtual_text_enabled = true
    vim.keymap.set('n', '<leader>dv', function()
        virtual_text_enabled = not virtual_text_enabled
        vim.diagnostic.config({
            virtual_text = virtual_text_enabled and {
                enabled = true,
                source = "if_many",
                spacing = 4,
                prefix = "●",
            } or false
        })
        print("Virtual text " .. (virtual_text_enabled and "enabled" or "disabled"))
    end, vim.tbl_extend('force', opts, { desc = "Toggle virtual text" }))

    -- Enhanced diagnostic severity filtering
    vim.keymap.set('n', '<leader>de', function()
        vim.diagnostic.config({
            virtual_text = {
                severity = { min = vim.diagnostic.severity.ERROR }
            }
        })
        print("Showing only errors")
    end, vim.tbl_extend('force', opts, { desc = "Show only errors" }))

    vim.keymap.set('n', '<leader>dw', function()
        vim.diagnostic.config({
            virtual_text = {
                severity = { min = vim.diagnostic.severity.WARN }
            }
        })
        print("Showing warnings and errors")
    end, vim.tbl_extend('force', opts, { desc = "Show warnings and above" }))

    vim.keymap.set('n', '<leader>da', function()
        vim.diagnostic.config({
            virtual_text = {
                enabled = true,
                source = "if_many",
                spacing = 4,
                prefix = "●",
            }
        })
        print("Showing all diagnostics")
    end, vim.tbl_extend('force', opts, { desc = "Show all diagnostics" }))

    -- Set up autocmds for optimized real-time diagnostic updates
    local diagnostic_augroup = vim.api.nvim_create_augroup("diagnostic_on_change", { clear = true })

    -- Debounced timer for text changes
    local diagnostic_timer = nil

    -- Trigger diagnostics on text changes with smart debouncing
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        group = diagnostic_augroup,
        callback = function()
            if diagnostic_timer then
                vim.fn.timer_stop(diagnostic_timer)
            end

            diagnostic_timer = vim.fn.timer_start(150, function()
                if vim.api.nvim_buf_is_valid(0) and vim.bo.buftype == "" then
                    -- Trigger LSP document sync which includes diagnostics
                    vim.lsp.buf_notify(0, 'textDocument/didChange', {
                        textDocument = {
                            uri = vim.uri_from_bufnr(0),
                            version = vim.lsp.util.buf_versions[0],
                        },
                        contentChanges = { { text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n') } }
                    })
                end
                diagnostic_timer = nil
            end)
        end,
    })

    -- Immediate updates for key events
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = diagnostic_augroup,
        callback = function()
            if vim.api.nvim_buf_is_valid(0) and vim.bo.buftype == "" then
                vim.diagnostic.show(nil, 0)
            end
        end,
    })

    -- Optimize display while typing
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = diagnostic_augroup,
        callback = function()
            -- Reduce visual noise while actively typing
            vim.diagnostic.config({
                virtual_text = {
                    enabled = true,
                    source = "if_many",
                    spacing = 2,
                    prefix = "●",
                    severity = { min = vim.diagnostic.severity.WARN }, -- Hide hints while typing
                }
            })
        end,
    })

    -- Restore full diagnostics when leaving insert mode
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = diagnostic_augroup,
        callback = function()
            vim.diagnostic.config({
                virtual_text = {
                    enabled = true,
                    source = "if_many",
                    spacing = 4,
                    prefix = "●",
                    -- Show all levels when not actively typing
                }
            })
        end,
    })
end

-- Auto-setup on require
M.setup()

return M
