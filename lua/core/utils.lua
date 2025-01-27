local M = {}

function M.is_hebrew_layout()
	-- Check keyboard layout using xset
	-- Returns true if Hebrew, false if English
	local layout = vim.fn.system("xset -q | grep LED | awk '{print $10}' | cut -c5"):gsub("%s+", "")
	return layout == "1"
end

function M.create_hebrew_block_augroup()
	local hebrew_block = vim.api.nvim_create_augroup("HebrewBlocker", { clear = true })

	-- Create autocmd for every normal mode key press
	vim.api.nvim_create_autocmd("CmdlineEnter", {
		group = hebrew_block,
		callback = function()
			if M.is_hebrew_layout() then
				-- Cancel the command
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

				-- Show notification using your existing noice.nvim setup
				vim.notify("Keyboard is in Hebrew!", vim.log.levels.WARN, {
					title = "Layout Warning",
					timeout = 1000, -- 1 second
				})

				return true -- Prevents the original command
			end
			return false
		end,
	})

	-- Block normal mode commands when in Hebrew
	vim.api.nvim_create_autocmd("BufEnter", {
		group = hebrew_block,
		callback = function()
			vim.keymap.set("n", ".", function()
				if M.is_hebrew_layout() then
					vim.notify("Keyboard is in Hebrew!", vim.log.levels.WARN, {
						title = "Layout Warning",
						timeout = 1000,
					})
					return
				end
				return "."
			end, { expr = true, buffer = true })
		end,
	})
end

return M
