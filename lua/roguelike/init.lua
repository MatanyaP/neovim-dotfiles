local M = {}
local display = require "roguelike.game.display"

function M.start_game()
  display.setup()
  -- More game initialization will go here later
end

-- Add command to start game
vim.api.nvim_create_user_command("RoguelikeStart", function()
  M.start_game()
end, {})

return M
