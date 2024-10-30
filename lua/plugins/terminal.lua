return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        on_open = function(term)
          vim.cmd "startinsert!"
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>close<CR>", {
            noremap = true,
            silent = true,
          })
        end,
        float_opts = {
          border = "curved",
          width = function()
            return math.min(vim.o.columns - 4, 150)
          end,
          height = function()
            return math.min(vim.o.lines - 4, 30)
          end,
        },
      }
    end,
  },
}
