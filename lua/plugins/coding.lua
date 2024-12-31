return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		opts = {
			panel = {
				enabled = false,
				auto_refresh = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				keymap = {
					accept = "<Tab>",
					next = "<C-j>",
					prev = "<C-k>",
					dismiss = "<C-h>",
				},
			},
			filetypes = {
				help = false,
				gitcommit = false,
				gitrebase = false,
				["."] = false,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		keys = {
			{
				"<C-s>",
				function()
					if require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
					end
				end,
				mode = { "i", "s" },
				desc = "Expand or jump in snippet",
			},
			{
				"<C-b>",
				function()
					if require("luasnip").jumpable(-1) then
						require("luasnip").jump(-1)
					end
				end,
				mode = { "i", "s" },
				desc = "Jump backward in snippet",
			},
		},
	},
}
