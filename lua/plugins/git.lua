return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr })
        vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr })
      end,
    },
  },
}
