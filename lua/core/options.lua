local opt = vim.opt

-- General
opt.guicursor = ""
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noselect"
opt.confirm = true
opt.autowrite = true

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.cursorline = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- Files
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.backup = false
-- Modified for Windows compatibility
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Performance
opt.synmaxcol = 240
opt.updatetime = 250
opt.hidden = true
opt.history = 100

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- File path handling for Windows
opt.shellslash = true
