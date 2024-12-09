return {
	formatting = {
		format = function(entry, item)
			local icons = require("config").icons.kinds
			if icons[item.kind] then
				item.kind = icons[item.kind] .. item.kind
			end
			return item
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "rose-pine",
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = {
					statusline = { "dashboard", "alpha" },
				},
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{ "filename", path = 1 },
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn", "info", "hint" },
					},
				},
				lualine_x = {
					"filetype",
					{
						"diff",
						symbols = {
							added = "+",
							modified = "~",
							removed = "-",
						},
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "fugitive", "trouble", "lazy" },
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			views = {
				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "75%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
		opts = {
			input = {
				enabled = true,
				default_prompt = "➤ ",
				prompt_align = "left",
				insert_only = true,
				border = "rounded",
				relative = "cursor",
			},
			select = {
				enabled = true,
				backend = { "telescope", "builtin" },
				builtin = {
					border = "rounded",
					relative = "cursor",
				},
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			text = {
				spinner = "pipe",
			},
			align = {
				bottom = true,
			},
			window = {
				relative = "editor",
			},
		},
	},
}
