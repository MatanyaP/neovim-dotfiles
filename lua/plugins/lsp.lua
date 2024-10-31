-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "nvimdev/lspsaga.nvim",
        opts = {
          symbol_in_winbar = {
            enable = false,
          },
          lightbulb = {
            enable = false,
          },
          ui = {
            border = "rounded",
          },
        },
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
        },
      },
    },
    config = function()
      -- Set up LSP diagnostics
      vim.diagnostic.config {
        virtual_text = {
          prefix = "●",
          source = "if_many",
          spacing = 4,
        },
        float = {
          source = "always",
          border = "rounded",
          header = "",
          prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }

      -- Set up capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.preselectSupport = true
      capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
      capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }

      -- Common on_attach function
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Use a mix of native LSP and Lspsaga commands with fallbacks
        vim.keymap.set("n", "K", function()
          local ok, _ = pcall(require("lspsaga.hover").render_hover_doc)
          if not ok then
            vim.lsp.buf.hover()
          end
        end, opts)

        vim.keymap.set("n", "gd", function()
          local ok, _ = pcall(require("lspsaga.definition").preview_definition)
          if not ok then
            vim.lsp.buf.definition()
          end
        end, opts)

        vim.keymap.set("n", "gr", function()
          local ok, _ = pcall(require("lspsaga.finder").lsp_finder)
          if not ok then
            vim.lsp.buf.references()
          end
        end, opts)

        vim.keymap.set("n", "gi", function()
          local ok, _ = pcall(require("lspsaga.finder").lsp_finder)
          if not ok then
            vim.lsp.buf.implementation()
          end
        end, opts)

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>fm", function()
          vim.lsp.buf.format { async = true }
        end, opts)

        -- Set autocommands conditional on server capabilities
        if client.server_capabilities.documentHighlightProvider then
          local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      -- Server configurations
      local servers = {
        -- Python configuration
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                inlayHints = {
                  functionReturnTypes = true,
                  variableTypes = true,
                  parameterTypes = true,
                },
              },
            },
          },
        },
        -- Lua configuration
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      }

      -- Set up servers
      local lspconfig = require "lspconfig"
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "pyright",
        "lua-language-server",
        -- Formatters
        "black",
        "stylua",
        -- Linters
        "flake8",
        "luacheck",
      },
    },
  },
}
