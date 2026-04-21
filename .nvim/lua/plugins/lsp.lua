return {
  -- Mason: install LSPs / formatters / linters to ~/.local/share/nvim/mason
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
    build = ":MasonUpdate",
    opts = { ui = { border = "rounded" } },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Language servers
        "lua-language-server",
        "elixir-ls",
        "terraform-ls",
        "tflint",
        "pyright",
        "ruff",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "json-lsp",
        "yaml-language-server",
        "tailwindcss-language-server",
        "svelte-language-server",
        "gopls",
        "clangd",
        -- Formatters
        "stylua",
        "prettierd",
        -- Linters
        "eslint_d",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- Default LSP configs + enable logic (native vim.lsp API).
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Diagnostics style
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = { spacing = 4, prefix = "●" },
        virtual_lines = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "󰌵",
          },
        },
        float = { border = "rounded" },
      })

      -- Register blink's extra capabilities with every server.
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
      end

      -- Per-server overrides
      vim.lsp.config("emmet_ls", {
        filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
      })

      vim.lsp.config("elixirls", {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/elixir-ls" },
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false,
          },
        },
      })

      vim.lsp.config("tailwindcss", {
        filetypes = { "html", "elixir", "eelixir", "heex" },
        init_options = {
          userLanguages = { elixir = "html-eex", eelixir = "html-eex", heex = "html-eex" },
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = { 'class[:]\\s*"([^"]*)"' },
            },
          },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
              },
            },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
            },
            diagnostics = { globals = { "vim", "Snacks", "P", "R", "RELOAD" } },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      vim.lsp.config("ts_ls", {
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/pubspec.json"] = "pubspec.yaml",
            },
          },
        },
      })

      vim.lsp.enable({
        "cssls",
        "jsonls",
        "html",
        "svelte",
        "emmet_ls",
        "clangd",
        "pyright",
        "ruff",
        "yamlls",
        "lua_ls",
        "gopls",
        "terraformls",
        "tflint",
        "elixirls",
        "tailwindcss",
        "ts_ls",
      })

      -- Buffer-local keymaps on attach. Sits alongside native gr* defaults.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local function bmap(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end
          bmap("n", "K",  vim.lsp.buf.hover,          "LSP: hover")
          bmap("n", "gd", vim.lsp.buf.definition,     "LSP: definition")
          bmap("n", "gD", vim.lsp.buf.declaration,    "LSP: declaration")
          bmap("n", "gi", vim.lsp.buf.implementation, "LSP: implementation")
          bmap("n", "gr", vim.lsp.buf.references,     "LSP: references")
          bmap("n", "<leader>cr", vim.lsp.buf.rename,          "LSP: rename")
          bmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
          bmap("n", "<leader>cs", vim.lsp.buf.signature_help, "LSP: signature help")

          -- Auto-enable inlay hints if server supports them.
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })
          end
        end,
      })
    end,
  },

  -- Rust via rustaceanvim (replaces nvim-lspconfig for rust_analyzer)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              procMacro = { enable = true },
              diagnostics = {
                disabled = { "unresolved-proc-macro", "unresolved-macro-call", "unlinked-file" },
              },
              enableExperimental = { procAttrMacros = true },
            },
          },
        },
        dap = {},
      }
    end,
  },
}
