local aug = vim.api.nvim_create_autocmd
local grp = vim.api.nvim_create_augroup("user_qol", {})

-- Highlight on yank
aug("TextYankPost", {
	group = grp,
	callback = function()
		vim.highlight.on_yank({ timeout = 120 })
	end,
})

-- Resize splits if window resized
aug("VimResized", { group = grp, command = "tabdo wincmd =" })
