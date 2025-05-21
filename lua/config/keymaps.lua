local map = vim.keymap.set
local opts = { silent = true }

-- your clipboard / delete / paste maps …
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
-- clipboard / delete / paste
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yank" })
map("x", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- file ops
map("n", "<leader>fs", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>i", { desc = "Save file" })
map("n", "<leader>fx", ":!chmod +x %<CR>", { desc = "Make file executable" })

-- navigation & splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<leader>rw", "<C-w>=", { desc = "Equalize splits" })

-- config reload
map("n", "<leader>r", ":so $MYVIMRC<CR>", { desc = "Reload config" })

-- buffers
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Telescope
map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
map("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live grep" })
map("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Buffers" })
map("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help tags" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
map("n", "gr", require("telescope.builtin").lsp_references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>lD", require("telescope.builtin").diagnostics, { desc = "Workspace diagnostics" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>lf", function() -- single source of truth
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Git (gitsigns + diffview)
map("n", "]c", require("gitsigns").next_hunk, { desc = "Next hunk" })
map("n", "[c", require("gitsigns").prev_hunk, { desc = "Prev hunk" })
map({ "n", "v" }, "<leader>gs", require("gitsigns").stage_hunk, { desc = "Stage hunk" })
map({ "n", "v" }, "<leader>gr", require("gitsigns").reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>gS", require("gitsigns").stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>gu", require("gitsigns").undo_stage_hunk, { desc = "Undo stage" })
map("n", "<leader>gR", require("gitsigns").reset_buffer, { desc = "Reset buffer" })
map("n", "<leader>gp", require("gitsigns").preview_hunk, { desc = "Preview hunk" })
map("n", "<leader>gb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diff view" })
map("n", "<leader>gD", ":DiffviewOpen ~<CR>", { desc = "Diff vs parent" })
map("n", "<leader>gv", ":DiffviewFileHistory %<CR>", { desc = "File history" })

-- Harpoon 2
map("n", "<leader>ha", function()
	require("harpoon"):list():append()
end, { desc = "Add file" })
map("n", "<leader>hm", function()
	require("harpoon").ui:toggle_quick_menu()
end, { desc = "Harpoon menu" })
map("n", "<leader>h1", function()
	require("harpoon"):list():select(1)
end)
map("n", "<leader>h2", function()
	require("harpoon"):list():select(2)
end)
map("n", "<leader>h3", function()
	require("harpoon"):list():select(3)
end)
map("n", "<leader>h4", function()
	require("harpoon"):list():select(4)
end)
map("n", "<C-n>", function()
	require("harpoon"):list():next()
end)
map("n", "<C-p>", function()
	require("harpoon"):list():prev()
end)

-- Oil
map("n", "-", require("oil").open, { desc = "Open parent directory" })
map("n", "<leader>e", require("oil").open, { desc = "Explorer (Oil)" })

-- LuaSnip (remapped away from <C-s>)
map({ "i", "s" }, "<C-l>", function()
	return require("luasnip").expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<C-l>"
end, { expr = true, desc = "Snippet expand/jump" })
map({ "i", "s" }, "<C-b>", function()
	require("luasnip").jump(-1)
end, { desc = "Snippet jump back" })

-- Autopairs fast-wrap
map("n", "<M-e>", function()
	require("nvim-autopairs").fastwrap()
end, { desc = "Fast wrap" })
