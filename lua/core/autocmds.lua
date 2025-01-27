local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Remove trailing whitespace on save
local format_group = augroup("FormatGroup", {})
autocmd("BufWritePre", {
	group = format_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- LSP Keymaps
local lsp_group = augroup("LspGroup", {})
autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local ok, keymaps = pcall(require, "core.keymaps")
		if ok then
			keymaps.setup_lsp_keymaps(args)
		else
			vim.notify("Failed to load LSP keymaps", vim.log.levels.WARN)
		end
	end,
})

-- Python-specific settings
-- In core/autocmds.lua
local python_group = augroup("PythonGroup", {})
autocmd("FileType", {
	group = python_group,
	pattern = "python",
	callback = function()
		-- Use treesitter for indentation
		vim.bo.indentexpr = "nvim_treesitter#indent()"

		-- Keep autoindent as fallback but disable smartindent
		vim.bo.autoindent = true
		vim.bo.smartindent = false
		vim.bo.cindent = false

		-- PEP 8 settings
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true

		-- Set textwidth for docstrings and comments
		vim.bo.textwidth = 88 -- Match black formatter's line length

		-- Improved indentkeys for Python
		vim.bo.indentkeys = table.concat({
			"0{,0},0),0]", -- Indent after brackets
			":", -- Indent after :
			"0#", -- Don't indent comments
			"e", -- Indent 'else' and similar keywords
			"0r", -- Indent return
			"0d", -- Indent def
			"0c", -- Indent class
			"0y", -- Indent yield
			"0w", -- Indent with
			"<>>", -- Indent after >
		}, ",")
	end,
})
