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
		"folke/trouble.nvim",
		event = "VeryLazy",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "everforest",
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
					{
						function()
							local ok, context = pcall(require, "treesitter-context")
							if not ok then
								return ""
							end

							local context_data = context.get_context()
							if not context_data or #context_data == 0 then
								return ""
							end

							-- Get the last context entry (most specific/inner scope)
							local node = context_data[#context_data]
							if not node then
								return ""
							end

							return "󰊕 " .. node[1]:match("^%s*(.-)%s*$") -- Strip whitespace
						end,
						color = { fg = "#7aa2f7" }, -- You can adjust the color to match your theme
					},
				},
				lualine_x = {
					-- {
					-- 	function()
					-- 		return vim.fn.system("xset -q | grep LED | awk '{print $10}' | cut -c5"):match("1") and "HE"
					-- 			or "EN"
					-- 	end,
					-- 	color = { fg = "#ff9e64" },
					-- },
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
				lualine_z = {
					{ "location" },
					{
						function()
							return vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")
						end,
					},
				},
			},
			extensions = { "fugitive", "trouble", "lazy" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
			zindex = 20,
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
