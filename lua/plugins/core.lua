return {
	-- Lua helpers
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- Flash jump-navigation
	{ "folke/flash.nvim", event = "VeryLazy", opts = {} },

	-- Which-key (key-hint popup)
	{ "folke/which-key.nvim", event = "VeryLazy", opts = { plugins = { spelling = true } } },
}
