local setup_auto_format = require("utils.lsp").setup_auto_format
local ih = require("inlay-hints")

setup_auto_format("go")

setup_auto_format("dart")
setup_auto_format("rs")

setup_auto_format("cpp")
setup_auto_format("cc")
setup_auto_format("h")

setup_auto_format("js", "FormatWrite")
setup_auto_format("css", "FormatWrite")
setup_auto_format("html", "FormatWrite")

setup_auto_format("jsx")
setup_auto_format("tsx")
setup_auto_format("svelte")
setup_auto_format("ts")
setup_auto_format("py")
setup_auto_format("dart")
setup_auto_format("lua", "lua require('stylua-nvim').format_file()")
setup_auto_format("terraform")
setup_auto_format("hcl")

setup_auto_format("ex")
setup_auto_format("exs")
setup_auto_format("heex")

setup_auto_format("sol")

setup_auto_format("yaml")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- Inlay hints on_attach for specific servers
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and (client.name == "clangd" or client.name == "gopls" or client.name == "ts_ls") then
      ih.on_attach(client, args.buf)
    end
  end,
})

-----------------------
-- Webdev
-----------------------
vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.config("jsonls", { capabilities = capabilities })
vim.lsp.config("html", { capabilities = capabilities })
vim.lsp.config("svelte", { capabilities = capabilities })
vim.lsp.config("emmet_ls", {
  capabilities = capabilities,
  filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
})
-----------------------
-- Random others
-----------------------
vim.lsp.config("clangd", { capabilities = capabilities })
vim.lsp.config("pyright", {
  capabilities = capabilities,
  cmd = { "pyright-python-langserver", "--stdio" },
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
vim.lsp.config("yamlls", {
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/pubspec.json"] = "pubspec.yaml",
      },
    },
  },
})
-----------------------
-- Lua
-----------------------
require("neodev").setup({})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

vim.lsp.config("gopls", {
  capabilities = capabilities,
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

vim.lsp.config("terraformls", { capabilities = capabilities })
vim.lsp.config("tflint", { capabilities = capabilities })

vim.lsp.config("elixirls", {
  cmd = { "elixir-ls" },
  capabilities = capabilities,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})

vim.lsp.config("efm", {
  capabilities = capabilities,
  filetypes = { "elixir", "ex" },
})

vim.lsp.config("tailwindcss", {
  filetypes = { "html", "elixir", "eelixir", "heex" },
  capabilities = capabilities,
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
        },
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
  "yamlls",
  "lua_ls",
  "gopls",
  "terraformls",
  "tflint",
  "elixirls",
  "efm",
  "tailwindcss",
})
