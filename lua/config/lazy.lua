-- Bootstrap lazy.nvim ----------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin spec lives in lua/plugins/*
require("lazy").setup({
	spec = { { import = "plugins" } },
	install = { colorscheme = { "everforest" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false },
})
