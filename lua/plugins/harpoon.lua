-- lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"

    -- REQUIRED
    harpoon:setup()

    -- Basic keymaps
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Add current file to harpoon list
    keymap("n", "<leader>ha", function()
      harpoon:list():append()
    end, opts)

    -- Toggle harpoon quick menu
    keymap("n", "<leader>hm", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, opts)

    -- Quick file navigation
    keymap("n", "<leader>1", function()
      harpoon:list():select(1)
    end, opts)
    keymap("n", "<leader>2", function()
      harpoon:list():select(2)
    end, opts)
    keymap("n", "<leader>3", function()
      harpoon:list():select(3)
    end, opts)
    keymap("n", "<leader>4", function()
      harpoon:list():select(4)
    end, opts)

    -- Navigate between marks
    keymap("n", "<C-p>", function()
      harpoon:list():prev()
    end, opts)
    keymap("n", "<C-n>", function()
      harpoon:list():next()
    end, opts)
  end,
}
