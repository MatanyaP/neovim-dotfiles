local M = {}

function M.setup()
	-- Create a protected call wrapper
	local function safe_require(module)
		local ok, err = pcall(require, module)
		if not ok then
			vim.notify("Error loading " .. module .. "\n" .. err, vim.log.levels.ERROR)
		end
		return ok, err
	end

	-- Load core modules
	safe_require("core.options")
	safe_require("core.autocmds")
	safe_require("core.lazy")

	-- Load keymaps separately
	local keymaps_ok, keymaps = safe_require("core.keymaps")
	if keymaps_ok then
		keymaps.setup()
	end

	-- local utils_ok, utils = safe_require("core.utils")
	-- if utils_ok then
	-- 	utils.create_hebrew_block_augroup()
	-- end
end

return M
