return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100,
    filetypes_denylist = {
      "dirbuf",
      "dirvish",
      "fugitive",
      "neo-tree",
      "TelescopePrompt",
    },
    under_cursor = true,
    large_file_cutoff = 2000,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map("]]", "next")
    map("[[", "prev")

    -- Clear illuminate on these events
    vim.api.nvim_create_autocmd("TextChanged", {
      callback = function()
        require("illuminate").pause()
      end,
    })

    vim.api.nvim_create_autocmd("TextChangedI", {
      callback = function()
        require("illuminate").pause()
      end,
    })
  end,
}
