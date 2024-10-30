-- General settings
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- Additional recommended settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Better UI
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 3 -- global statusline

-- Better scrolling
vim.opt.scrolloff = 8
vim.opt.smoothscroll = true

-- Better search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Better splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Persistent undo
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Performance
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500
vim.opt.ttimeoutlen = 10

-- Better formatting
vim.opt.formatoptions = "jcroqlnt"

-- Disable providers you don't need
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
