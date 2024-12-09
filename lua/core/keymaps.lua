local M = {}

local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

function M.setup()
	-- Clipboard operations
	map("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })
	map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
	map("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })
	map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

	-- File operations
	map("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save File" })
	map("n", "<leader>fe", "<cmd>Ex<cr>", { desc = "Open Explorer" })
	map("n", "<leader>fq", "<cmd>q<cr>", { desc = "Quit" })
	map("i", "<C-s>", "<Cmd>w<CR>", { desc = "Save file in insert mode" })

	-- Movement and Navigation
	map("n", "<leader>h", "<C-w>h", { desc = "Move to left window" })
	map("n", "<leader>j", "<C-w>j", { desc = "Move to bottom window" })
	map("n", "<leader>k", "<C-w>k", { desc = "Move to top window" })
	map("n", "<leader>l", "<C-w>l", { desc = "Move to right window" })

	-- Resize windows
	map("n", "<leader>rw", "<C-w>=", { desc = "Equalize window sizes" })

	-- Reload configuration
	map("n", "<leader>r", function()
		vim.cmd("so")
	end, { desc = "Reload Neovim config" })

	-- Search and Replace
	map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace current word" })

	-- File permissions
	map("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

	-- Quickfix navigation
	map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
	map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

	-- Buffer navigation
	map("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next buffer" })
	map("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Previous buffer" })
	map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

	-- Telescope
	map("n", "<leader>ff", function()
		require("telescope.builtin").find_files()
	end, { desc = "Find Files" })
	map("n", "<leader>fg", function()
		require("telescope.builtin").live_grep()
	end, { desc = "Live Grep" })
	map("n", "<leader>fb", function()
		require("telescope.builtin").buffers()
	end, { desc = "Buffers" })
	map("n", "<leader>fh", function()
		require("telescope.builtin").help_tags()
	end, { desc = "Help Tags" })

	-- Git
	map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git Status" })
	map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git Push" })
	map("n", "<leader>gP", "<cmd>Git pull --rebase<CR>", { desc = "Git Pull (Rebase)" })

	-- LSP
	map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
	map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace Diagnostics" })
	map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
	map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
	map("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format Document" })

	-- Trouble
	map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
	map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
	map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { desc = "Document Diagnostics" })

	-- Tests
	map("n", "<leader>tn", function()
		require("neotest").run.run()
	end, { desc = "Run Nearest Test" })
	map("n", "<leader>tf", function()
		require("neotest").run.run(vim.fn.expand("%"))
	end, { desc = "Run Current File Tests" })
	map("n", "<leader>ts", function()
		require("neotest").summary.toggle()
	end, { desc = "Toggle Test Summary" })

	-- Harpoon
	map("n", "<leader>ha", function()
		require("harpoon.mark").add_file()
	end, { desc = "Add File to Harpoon" })
	map("n", "<leader>hm", function()
		require("harpoon.ui").toggle_quick_menu()
	end, { desc = "Toggle Harpoon Menu" })
	map("n", "<leader>h1", function()
		require("harpoon.ui").nav_file(1)
	end, { desc = "Harpoon File 1" })
	map("n", "<leader>h2", function()
		require("harpoon.ui").nav_file(2)
	end, { desc = "Harpoon File 2" })
	map("n", "<leader>h3", function()
		require("harpoon.ui").nav_file(3)
	end, { desc = "Harpoon File 3" })
	map("n", "<leader>h4", function()
		require("harpoon.ui").nav_file(4)
	end, { desc = "Harpoon File 4" })

	-- UndoTree
	map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

	-- Zen Mode
	map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })

	-- tmux-sessionizer
	map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Sessionizer" })

	-- Fun
	map("n", "<leader>mf", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it Rain" })
end

-- LSP Keymaps
function M.setup_lsp_keymaps(event)
	local opts = { buffer = event.buf }

	map("n", "gd", vim.lsp.buf.definition, { buffer = opts.buffer, desc = "Go to Definition" })
	map("n", "K", vim.lsp.buf.hover, { buffer = opts.buffer, desc = "Hover Documentation" })
	map("n", "gi", vim.lsp.buf.implementation, { buffer = opts.buffer, desc = "Go to Implementation" })
	map("n", "gr", vim.lsp.buf.references, { buffer = opts.buffer, desc = "Go to References" })
	map("n", "[d", vim.diagnostic.goto_prev, { buffer = opts.buffer, desc = "Previous Diagnostic" })
	map("n", "]d", vim.diagnostic.goto_next, { buffer = opts.buffer, desc = "Next Diagnostic" })
	map("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = opts.buffer, desc = "Signature Help" })
end

return M
