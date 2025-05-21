return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = { mappings = { i = { ["<C-h>"] = "which_key" } } },
			pickers = { find_files = { hidden = true } },
			extensions = {},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			pcall(telescope.load_extension, "fzf")
		end,
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
}
