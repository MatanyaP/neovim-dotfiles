local harpoon = require("harpoon")
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
	map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
	map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
	map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
	map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

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

	-- LSP
	map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
	map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace Diagnostics" })
	map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
	map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
	map("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format Document" })

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

	map("n", "<leader>ha", function()
		harpoon:list():add()
	end, { desc = "Add File to Harpoon" })

	map("n", "<leader>hm", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Toggle Harpoon Menu" })

	-- You can optionally use the Telescope UI instead
	-- map("n", "<leader>hm", function()
	--     toggle_telescope(harpoon:list())
	-- end, { desc = "Toggle Harpoon Menu" })

	map("n", "<leader>h1", function()
		harpoon:list():select(1)
	end, { desc = "Harpoon File 1" })

	map("n", "<leader>h2", function()
		harpoon:list():select(2)
	end, { desc = "Harpoon File 2" })

	map("n", "<leader>h3", function()
		harpoon:list():select(3)
	end, { desc = "Harpoon File 3" })

	map("n", "<leader>h4", function()
		harpoon:list():select(4)
	end, { desc = "Harpoon File 4" })

	-- Toggle between harpoon files
	map("n", "<C-n>", function()
		harpoon:list():next()
	end, { desc = "Next harpoon file" })

	map("n", "<C-p>", function()
		harpoon:list():prev()
	end, { desc = "Previous harpoon file" })

	-- UndoTree
	map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

	-- Zen Mode
	map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })

	-- -- tmux-sessionizer
	-- map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Sessionizer" })
	-- -- Split vertical with new session
	-- map("n", "<leader>tv", "<cmd>silent !tmux-sessionizer -v<CR>", { desc = "Sessionizer (Vertical Split)" })
	--
	-- -- Split horizontal with new session
	-- map("n", "<leader>th", "<cmd>silent !tmux-sessionizer -h<CR>", { desc = "Sessionizer (Horizontal Split)" })

	-- Move lines
	map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
	map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
	map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
	map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
	map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
	map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
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
