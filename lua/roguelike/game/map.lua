local CONFIG = require "roguelike.game.config"

local map = {
  width = CONFIG.WINDOW_WIDTH,
  height = CONFIG.WINDOW_HEIGHT,
  tiles = {}, -- You decide the structure!
}

function map.generate()
  -- Generate map tiles
  for x = 1, map.width do
    map.tiles[x] = {}
    for y = 1, map.height do
      -- Generate tile
      map.tiles[x][y] = {
        type = "floor",
        explored = false,
      }
    end
  end
end
