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

		-- Disable other indentation methods to avoid conflicts
		vim.bo.autoindent = false
		vim.bo.smartindent = false
		vim.bo.cindent = false

		-- PEP 8 settings
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true

		-- Enable these options for better indentation behavior
		vim.bo.indentkeys = table.concat({
			"0{,0},0),0]", -- Indent after brackets
			":", -- Indent after :
			"<:>", -- Indent after :
			"e", -- Else
			"!^F", -- Don't indent preprocessor
			"o", -- Open new line
			"O", -- Open new line above
			"0#", -- Don't indent comments
			"<>>", -- Indent after >
		}, ",")
	end,
})
