local config = require "roguelike.game.config"
local M = {}

-- Store buffer and window IDs
M.buf = nil
M.win = nil

-- Initialize display
function M.setup()
  -- Create new buffer
  M.buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_set_option_value("modifiable", false, { buf = M.buf })
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = M.buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = M.buf })

  -- Calculate window position (center of screen)
  local ui = vim.api.nvim_list_uis()[1]
  local width = config.WINDOW_WIDTH
  local height = config.WINDOW_HEIGHT

  -- Create centered floating window
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = (ui.width - width) / 2,
    row = (ui.height - height) / 2,
    style = "minimal",
    border = "single",
  }

  M.win = vim.api.nvim_open_win(M.buf, true, opts)
end

return M
