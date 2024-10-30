return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "79" },
        },
      },
    },
  },
}
