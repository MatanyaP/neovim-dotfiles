return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		version = false,
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				mappings = {
					i = {
						["<C-n>"] = "cycle_history_next",
						["<C-p>"] = "cycle_history_prev",
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"dist/",
					"build/",
					"%.lock",
					"myenv/",
					"%.venv/",
					"venv/",
					"env/",
					"%.env/",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					-- Update this section too
					file_ignore_patterns = {
						"^.git/",
						"^node_modules/",
						"^myenv/",
						"^.venv/",
						"^venv/",
						"^env/",
						"^.env/",
					},
				},
				live_grep = {
					additional_args = function(opts)
						return {
							"--hidden",
							"--glob",
							"!.git/",
							"--glob",
							"!node_modules/",
							"--glob",
							"!venv/",
							"--glob",
							"!.venv/",
						}
					end,
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>t"] = { name = "+test" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>h"] = { name = "+harpoon" },
				["<leader>u"] = { name = "+undo" },
				["<leader>z"] = { name = "+zen" },
				["<leader>x"] = { name = "+trouble" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>m"] = { name = "+misc" },
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			skip_confirm_for_simple_edits = true,
			default_file_explorer = true,
			delete_to_trash = true,
			experimental_watch_for_changes = true,
			show_hidden = true,
			-- Add back keymaps but with our desired configuration
			keymaps = {
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-r>"] = "actions.refresh",
				["_"] = "actions.parent",
				["g."] = "actions.toggle_hidden",
				["q"] = "actions.close",
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
			float = {
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
		},
		config = function(_, opts)
			require("oil").setup(opts)
			-- Add our custom binding for opening oil in current directory
			vim.keymap.set("n", "-", "<CMD>Oil .<CR>", { desc = "Open current directory in oil" })
			vim.keymap.set("n", "<leader>e", "<CMD>Oil .<CR>", { desc = "Open current directory in oil" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED: Basic setup
			harpoon:setup({
				settings = {
					save_on_toggle = false,
					sync_on_ui_close = false,
					key = function()
						return vim.loop.cwd()
					end,
				},
			})

			-- Optional: Configure Telescope UI
			-- Comment this out if you don't use Telescope
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			-- Add UI extensions for splits/tabs in Harpoon menu
			harpoon:extend({
				UI_CREATE = function(cx)
					vim.keymap.set("n", "<C-v>", function()
						harpoon.ui:select_menu_item({ vsplit = true })
					end, { buffer = cx.bufnr })

					vim.keymap.set("n", "<C-x>", function()
						harpoon.ui:select_menu_item({ split = true })
					end, { buffer = cx.bufnr })

					vim.keymap.set("n", "<C-t>", function()
						harpoon.ui:select_menu_item({ tabedit = true })
					end, { buffer = cx.bufnr })
				end,
			})
		end,
	},
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup()
		end,
	},
}
