-- Re-usable on_attach ----------------------------------------------------
local M = {}

M.on_attach = function(client, bufnr)
	local map = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map("gd", vim.lsp.buf.definition, "Go to definition")
	map("gi", vim.lsp.buf.implementation, "Go to implementation")
	map("K", vim.lsp.buf.hover, "Hover")
	map("gr", require("telescope.builtin").lsp_references, "References")
	map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
	map("]d", vim.diagnostic.goto_next, "Next diagnostic")
	map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
	map("<leader>lr", vim.lsp.buf.rename, "Rename")
	map("<leader>la", vim.lsp.buf.code_action, "Code action")
end

-- nvim-cmp capability compat
M.capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

return M
