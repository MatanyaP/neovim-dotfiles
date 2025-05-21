-- lua/plugins/lsp.lua  ────────────────────────────────────────────────
local servers = {
	-- always-on
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"tailwindcss",
	"html",
	"cssls",
	"jsonls",
	"yamlls",
	"dockerls",
	"bashls",
	"marksman",
}

local optional = { "eslint", "stylelint_lsp", "emmet_ls", "helm_ls", "ansiblels" }

return {
	-- ➊ Installer
	{ "mason-org/mason.nvim", cmd = "Mason", opts = {} },

	{ -- ➋ mason-lspconfig just installs the binaries
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = { ensure_installed = vim.list_extend(vim.deepcopy(servers), optional) },
	},

	{ -- ➌ Real LSP setup happens here
		"neovim/nvim-lspconfig",
		dependencies = "hrsh7th/cmp-nvim-lsp",
		config = function()
			local lsp = require("lspconfig")
			local util = require("config.lsp") -- your on_attach/capabilities helpers

			-- loop over the list instead of opts = {}, to avoid the .setup() trap
			for _, server in ipairs(vim.list_extend(vim.deepcopy(servers), optional)) do
				if lsp[server] then
					lsp[server].setup({
						on_attach = util.on_attach,
						capabilities = util.capabilities,
						settings = (server == "lua_ls") and {
							Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } },
						} or nil,
					})
				end
			end
		end,
	},

	-- ➍ Formatter
	{ "stevearc/conform.nvim", event = "BufWritePre", opts = { format_on_save = { lsp_fallback = true } } },
}
