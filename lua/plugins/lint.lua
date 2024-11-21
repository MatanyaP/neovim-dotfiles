return {
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufEnter", "BufNewFile" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    init = function()
      -- Create a timer for debouncing
      local timer = assert(vim.loop.new_timer())
      local DEBOUNCE_TIME = 100 -- milliseconds

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          -- Cancel any previous timer
          timer:stop()

          -- Start new timer
          timer:start(
            DEBOUNCE_TIME,
            0,
            vim.schedule_wrap(function()
              local lint = require "lint"
              -- Only try to lint if we have a valid parser for the filetype
              local names = lint._resolve_linter_by_ft(vim.bo.filetype)
              if #names > 0 then
                lint.try_lint()
              end
            end)
          )
        end,
      })
    end,
    config = function()
      local lint = require "lint"

      -- Configure linters by filetype
      lint.linters_by_ft = {
        python = { "flake8" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      -- Configure flake8
      lint.linters.flake8 = {
        cmd = "flake8",
        args = {
          "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
          "--max-line-length=79",
          "--max-complexity=10",
        },
        stdin = true,
        stream = "stdout",
        ignore_exitcode = true, -- Important: Don't fail on exit code
        parser = require("lint.parser").from_pattern(
          "([^:]+):(%d+):(%d+):(%w+):(.*)",
          { "file", "lnum", "col", "code", "message" },
          {
            ["source"] = "flake8",
            ["severity"] = vim.diagnostic.severity.WARN,
          }
        ),
      }
    end,
  },
}
