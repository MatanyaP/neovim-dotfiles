return {
	-- Fun matrix effect
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{ "<leader>mf", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it Rain" },
		},
	},
	-- Better movement
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
			{ "gs", mode = { "n" }, desc = "Leap from windows" },
		},
		config = function()
			require("leap").add_default_mappings()
			-- Cross-window motions
			vim.keymap.set("n", "gs", function()
				require("leap").leap({
					target_windows = vim.tbl_filter(function(win)
						return vim.api.nvim_win_get_config(win).focusable
					end, vim.api.nvim_tabpage_list_wins(0)),
				})
			end)
		end,
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
