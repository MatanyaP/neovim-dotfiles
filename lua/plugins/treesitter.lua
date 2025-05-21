return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = "all",
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	{ "nvim-treesitter/nvim-treesitter-context", opts = {} },
	{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
}
