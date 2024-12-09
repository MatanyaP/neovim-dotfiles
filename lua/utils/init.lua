local M = {}

-- Reload a module
function M.reload(name)
    require("plenary.reload").reload_module(name)
end

-- Helper function for keymaps
function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Create directory if it doesn't exist
function M.ensure_dir(path)
    local ok = vim.fn.isdirectory(path)
    if not ok then
        vim.fn.mkdir(path, "p")
    end
end

-- Custom colorscheme setup
function M.setup_colors()
    local background = "dark"
    vim.opt.background = background

    -- Adapt to terminal theme if transparent background is enabled
    local transparent_background = true
    if transparent_background then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

return M
