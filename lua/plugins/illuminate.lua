-- lua/plugins/illuminate.lua
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 500,
    large_file_cutoff = 2000,
    min_count_to_highlight = 2,
  },
  config = function()
    require("illuminate").configure {
      delay = 500,
      large_file_cutoff = 2000,
      min_count_to_highlight = 2,
    }

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map("]]", "next")
    map("[[", "prev")
  end,
}
