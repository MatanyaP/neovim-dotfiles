return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"cmp-nvim-lsp",
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = false,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
								typeCheckingMode = "basic",
							},
						},
					},
				},
				ruff = {
					on_attach = function(client, bufnr)
						-- Disable hover in favor of pyright
						client.server_capabilities.hoverProvider = false
					end,
				},
				ts_ls = {},
				rust_analyzer = {},
				html = {},
				cssls = {},
				jsonls = {},
				yamlls = {},
				dockerls = {},
				bashls = {},
			},
		},
		config = function(_, opts)
			local capabilities =
				vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities(), {
					textDocument = {
						definition = {
							dynamicRegistration = true,
							linkSupport = true,
						},
					},
				})

			local lspconfig = require("lspconfig")

			-- Setup diagnostics
			vim.diagnostic.config(opts.diagnostics)

			-- Create autocommand for Python files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function(args)
					local buffer = args.buf
					-- Check if pyright is already running
					local has_pyright = false
					for _, client in ipairs(vim.lsp.get_clients({ bufnr = buffer })) do
						if client.name == "pyright" then
							has_pyright = true
							break
						end
					end

					if not has_pyright then
						-- Start pyright with debug info
						vim.notify("Starting Pyright...", vim.log.levels.INFO)
						local ok = pcall(vim.cmd, "LspStart pyright")
						if not ok then
							vim.notify("Failed to start Pyright!", vim.log.levels.ERROR)
						end
					end
				end,
			})
			vim.api.nvim_create_user_command("VerifyPyright", function()
				-- Check pyright installation
				local npm_pyright = vim.fn.system("which pyright-langserver")
				vim.notify("Pyright path: " .. npm_pyright, vim.log.levels.INFO)

				-- Check if it's working
				local clients = vim.lsp.get_active_clients()
				local has_pyright = false
				for _, client in ipairs(clients) do
					if client.name == "pyright" then
						has_pyright = true
						break
					end
				end
				vim.notify("Pyright active: " .. tostring(has_pyright), vim.log.levels.INFO)
			end, {})

			-- Setup servers with modified config
			for server, server_opts in pairs(opts.servers) do
				-- Add capabilities to each server
				server_opts.capabilities = capabilities

				-- Special handling for pyright
				if server == "pyright" then
					server_opts.settings = vim.tbl_deep_extend("force", server_opts.settings or {}, {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
								indexing = true,
							},
						},
					})

					-- Handle exit with code 1
					server_opts.on_exit = function(code, signal)
						if code == 1 and signal == 0 then
							-- Ignore expected exit
							return
						end
					end
				end

				-- Setup the server
				lspconfig[server].setup(server_opts)
			end

			-- Additional setup for better LSP experience
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.server_capabilities.definitionProvider then
						vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
					end
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"black",
				"prettier",
				"eslint_d",
				"shellcheck",
				"shfmt",
				-- remove pyright from here as we'll install it via npm
			},
		},
		config = function(_, opts)
			local mason = require("mason")
			mason.setup({
				install_root_dir = vim.fn.stdpath("data") .. "/mason",
				ui = {
					check_outdated_packages_on_open = false,
					border = "rounded",
				},
			})

			-- Store ensure_installed packages globally for our custom command
			_G.mason_ensure_installed = opts.ensure_installed
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				-- formatting = {
				-- 	format = function(entry, item)
				-- 		local icons = require("config").icons.kinds
				-- 		if icons[item.kind] then
				-- 			item.kind = icons[item.kind] .. item.kind
				-- 		end
				-- 		return item
				-- 	end,
				-- 	fields = { "kind", "abbr", "menu" },
				-- 	expandable_indicator = true,
				-- },
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},
}
