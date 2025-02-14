-- return {
-- 	{
-- 		"MatanyaP/keyboard-guard.nvim",
-- 		event = "VeryLazy",
-- 		opts = {
-- 			notification = {
-- 				style = "default", -- Better visibility for debugging
-- 				message = "Please switch to English layout!",
-- 			},
-- 			modes = {
-- 				n = true, -- protect normal mode
-- 				i = false, -- don't protect insert mode
-- 				c = true, -- protect command mode
-- 			},
-- 		},
-- 	},
-- }
return {
	{
		dir = "~/Desktop/personal/keyboard-guard.nvim",
		config = function()
			require("keyboard_guard").setup({
				notification = {
					style = "default",
					message = "Keyboard is not in English layout!",
				},
				modes = {
					n = true,
					i = false,
					c = true,
				},
				layout_switch = {
					enabled = true, -- Enable the feature
					auto_restore = true, -- Automatically restore previous layout in insert mode
				},
			})

			-- Add debug command
			vim.api.nvim_create_user_command("KGDebug", function()
				local layout = vim.fn.system("xset -q | grep LED | awk '{print $10}' | cut -c5")
				vim.notify("Layout debug info:\nRaw output: " .. layout .. "\nTrimmed: " .. layout:gsub("%s+", ""))
			end, {})

			-- Reload command
			vim.api.nvim_create_user_command("KGReload", function()
				package.loaded["keyboard_guard"] = nil
				require("keyboard_guard").setup({
					notification = {
						style = "minimal",
						message = "Keyboard is not in English layout Matan!",
					},
					modes = {
						n = true,
						i = false,
						c = true,
					},
				})
				vim.notify("Keyboard Guard reloaded!")
			end, {})
		end,
		lazy = false,
	},
}
