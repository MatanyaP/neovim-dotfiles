return {
	{
		"neanias/everforest-nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.opt.background = "dark"
			vim.cmd.colorscheme("everforest")
		end,
	},
}
