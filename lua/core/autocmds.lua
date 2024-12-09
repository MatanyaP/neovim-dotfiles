local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove trailing whitespace on save
local format_group = augroup('FormatGroup', {})
autocmd('BufWritePre', {
    group = format_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- LSP Keymaps
local lsp_group = augroup('LspGroup', {})
autocmd('LspAttach', {
    group = lsp_group,
    callback = require("core.keymaps").setup_lsp_keymaps
})
