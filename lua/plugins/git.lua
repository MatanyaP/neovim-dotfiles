return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			current_line_blame = true,
			on_attach = function(buf)
				local gs = package.loaded.gitsigns
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
				end
				map("]c", gs.next_hunk, "Next hunk")
				map("[c", gs.prev_hunk, "Prev hunk")
			end,
		},
	},
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
}
