return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { { "prettier" } },
				typescript = { { "prettier" } },
				javascriptreact = { { "prettier" } },
				typescriptreact = { { "prettier" } },
				css = { { "prettier" } },
				html = { { "prettier" } },
				json = { { "prettier" } },
				yaml = { { "prettier" } },
				markdown = {},
				rust = { "rustfmt" },
				go = { "gofmt" },
			},
			formatters = {
				stylua = {
					prepend_args = { "--column-width", "140" },
				},
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
				exclude_filetypes = { "markdown" },
			},
		},
	},
}
