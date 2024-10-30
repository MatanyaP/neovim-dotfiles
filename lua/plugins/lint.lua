return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "flake8" },
    },
    linters = {
      flake8 = {
        args = { "--max-line-length=79" },
      },
    },
  },
}
