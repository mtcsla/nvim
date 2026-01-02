require('smart-splits').setup({
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
        'nofile',
        'quickfix',
        'prompt',
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = { 'NvimTree' },
    -- the default number of lines/columns to resize by at a time
    default_amount = 3,
    -- at edge behavior
    at_edge = 'wrap',
    -- when moving cursor between splits left or right,
    -- place the cursor on the first or last column of the current line.
    -- (Does not apply to up/down)
    move_cursor_same_row = false,
    -- whether the cursor should follow the buffer when swapping
    cursor_follows_swapped_bufs = false,
    -- resize mode options
    resize_mode = {
        -- key to exit resize mode
        quit_key = '<ESC>',
        -- keys to use for moving in resize mode
        -- in order of left, down, up, right
        resize_keys = { 'h', 'j', 'k', 'l' },
        -- set to true to silence the notifications
        -- when entering/exiting resize mode
        silent = false,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
            on_enter = nil,
            on_leave = nil,
        },
    },
    -- ignore these autocmd events (via :h eventignore) while processing
    -- smart-splits.nvim computations, which involve visiting different
    -- buffers and windows. These events will be ignored during processing,
    -- and un-ignored on completed. This only applies to resize events,
    -- not cursor movement events.
    ignored_events = {
        'BufEnter',
        'WinEnter',
    },
    -- enable or disable the tmux integration
    multiplexer_integration = nil,
    -- disable multiplexer navigation if current multiplexer pane is zoomed
    disable_multiplexer_nav_when_zoomed = true,
})

-- resizing splits
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)

-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- Note: move_cursor_previous doesn't exist, using move_cursor_left as fallback
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_left)

-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
