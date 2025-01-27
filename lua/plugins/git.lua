return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			current_line_blame = true,
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- Navigation
				map("n", "]c", gs.next_hunk, "Next Hunk")
				map("n", "[c", gs.prev_hunk, "Previous Hunk")

				-- Actions
				map({ "n", "v" }, "<leader>gs", gs.stage_hunk, "Stage Hunk")
				map({ "n", "v" }, "<leader>gr", gs.reset_hunk, "Reset Hunk")
				map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>gd", gs.diffthis, "Diff This")
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, "Diff Against ~")
			end,
		},
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy", -- Load earlier
		keys = {
			{ "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
			{ "<leader>gP", "<cmd>Git pull --rebase<cr>", desc = "Git pull (rebase)" },
		},
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gc", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
		},
	},
}
