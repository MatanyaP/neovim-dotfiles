local M = {}

-- Remove Hebrew layout detection as it's Linux-specific
-- Add Windows-specific path handling
function M.normalize_path(path)
	if vim.fn.has("win32") == 1 then
		return path:gsub("/", "\\")
	end
	return path
end

return M
