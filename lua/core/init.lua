local M = {}

function M.setup()
	-- Load core modules in specific order
	require("core.options")
	require("core.autocmds")
	require("core.keymaps").setup()
	require("core.lazy") -- Load this last to ensure all settings are applied
end

return M
