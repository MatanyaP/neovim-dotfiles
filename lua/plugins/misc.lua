return {
	-- Fun matrix effect
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{ "<leader>mf", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it Rain" },
		},
	},
	-- Better movement with flash
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			labels = "asdfghjklqwertyuiopzxcvbnm",
			search = {
				-- search/jump in all windows
				multi_window = true,
				-- search direction
				forward = true,
				-- when `false`, find only matches in the given direction
				wrap = true,
				---@type Flash.Pattern.Mode
				-- Each mode will take ignorecase and smartcase into account.
				-- * exact: exact match
				-- * search: regular search
				-- * fuzzy: fuzzy search
				-- * fun(str): custom function that returns a pattern
				--   For example, to only match at the beginning of a word:
				--   mode = function(str)
				--     return "\\<" .. str
				--   end,
				mode = "exact",
			},
			jump = {
				-- save location in the jumplist
				jumplist = true,
				-- jump position
				pos = "start", ---@type "start" | "end" | "range"
				-- add pattern to search history
				history = false,
				-- add pattern to search register
				register = false,
				-- clear highlight after jump
				nohlsearch = false,
				-- automatically jump when there is only one match
				autojump = false,
			},
			label = {
				-- allow uppercase labels
				uppercase = true,
				-- position of the label extmark
				style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
				-- flash tries to reuse labels that were already assigned to a position,
				-- when typing more characters. By default only labels in the same column are
				-- reused. See |Flash.Style.reuse| for other options.
				reuse = "same-column",
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	-- Hide sensitive information
	{
		"laytan/cloak.nvim",
		event = "BufReadPre",
		opts = {
			enabled = true,
			cloak_character = "*",
			highlight_group = "Comment",
			patterns = {
				{
					file_pattern = {
						".env*",
						"wrangler.toml",
						".dev.vars",
					},
					cloak_pattern = "=.+",
				},
			},
		},
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
		},
	},
}
