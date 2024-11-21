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
            max_height = 0.6,
            max_width = 0.6,
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
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = false, -- Reduce processing
          max_concurrent_diagnostic = 100,
        },
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          max_width = 60,
          max_height = 20,
        },
      }

      -- Set up capabilities

      -- Cache capabilities
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = false, -- Disable file watching
            },
          },
        }
      )

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
        -- Disable certain features for better performance
        if client.name == "pyright" then
          client.server_capabilities.documentFormattingProvider = false
        end
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

        -- Navigate to next diagnostic
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", buffer = bufnr })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = bufnr })

        -- Open diagnostic float window
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic", buffer = bufnr })

        -- Show diagnostic list
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List", buffer = bufnr })

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
          vim.api.nvim_create_autocmd({ "CursorHold" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      -- Initialize mason and mason-lspconfig first
      require("mason").setup {
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }

      require("mason-lspconfig").setup {
        ensure_installed = {
          "pyright",
          "lua_ls",
          "ts_ls",
          "eslint",
        },
        automatic_installation = true,
      }

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
        -- TypeScript/JavaScript LSP
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        -- ESLint LSP
        eslint = {
          filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
          settings = {
            workingDirectory = { mode = "auto" },
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
              hint = {
                enable = true,
                arrayIndex = "Enable",
                setType = true,
                paramName = "All",
                paramType = true,
                semicolon = "All",
              },
            },
          },
        },
      }

      -- Set up each LSP server
      local lspconfig = require "lspconfig"
      for server_name, server_config in pairs(servers) do
        local config = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
          flags = {
            debounce_text_changes = 150,
          },
        }, server_config)

        lspconfig[server_name].setup(config)
      end
    end,
  },
  -- Mason configuration
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        -- LSP
        "pyright",
        "lua-language-server",
        "typescript-language-server",
        "eslint-lsp",

        -- Formatters
        "black",
        "stylua",
        "prettierd",

        -- Linters
        "flake8",
        "luacheck",
        "eslint_d",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
