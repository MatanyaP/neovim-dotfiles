-- lua/plugins/formatting.lua
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- Extend the LazyVim formatters
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        ["javascript.jsx"] = { "prettierd" },
        ["typescript.tsx"] = { "prettierd" },
        json = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
      },

      -- Formatter configurations
      formatters = {
        black = {
          prepend_args = { "--line-length", "79" },
        },
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand "~/.config/nvim/.prettierrc.json",
          },
        },
      },
    },
  },
}
