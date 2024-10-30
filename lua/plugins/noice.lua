return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["cmp.entry.get_documentation"] = false, -- Disable noice for cmp doc
        },
      },
    },
  },
}
