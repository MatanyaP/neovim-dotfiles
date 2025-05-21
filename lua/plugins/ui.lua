return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { plugins = { spelling = true } },
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({ { "<leader>", group = "󰘳 leader" } })
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = { lsp = { progress = { enabled = true } } },
	},
	{ "j-hui/fidget.nvim", event = "LspAttach", opts = {} }, -- LSP progress UI :contentReference[oaicite:6]{index=6}
	{ "folke/trouble.nvim", cmd = "Trouble", opts = { mode = "diagnostics", auto_open = false } }, -- rewrite in v3 :contentReference[oaicite:7]{index=7}
	{
		"stevearc/oil.nvim",
		keys = { { "-", "<CMD>Oil<CR>" } }, -- buffer-style file-browser :contentReference[oaicite:8]{index=8}
		opts = { view_options = { show_hidden = true } },
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "BufReadPost", opts = {} }, -- v3 entry-point “ibl” :contentReference[oaicite:9]{index=9}
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2", -- new harpoon2 API :contentReference[oaicite:10]{index=10}
		dependencies = "nvim-lua/plenary.nvim",
		opts = {},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "stevearc/dressing.nvim", lazy = true }, -- fallback UI
}
