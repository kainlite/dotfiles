local lspconfig = require("lspconfig")
local setup_auto_format = require("utils.lsp").setup_auto_format
local ih = require("inlay-hints")

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
setup_auto_format("hcl")

setup_auto_format("ex")
setup_auto_format("exs")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-----------------------
-- Webdev
-----------------------
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end,
    },
  },
})
lspconfig.html.setup({
  capabilities = capabilities,
})
lspconfig.tailwindcss.setup({ capabilities = capabilities })
lspconfig.svelte.setup({ capabilities = capabilities })
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
})
-----------------------
-- Random others
-----------------------
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = function(c, b)
    ih.on_attach(c, b)
  end,
})
-- lspconfig.pylsp.setup({ capabilities = capabilities })
require("lspconfig").pyright.setup({
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
require("lspconfig").yamlls.setup({
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

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

require("lspconfig").gopls.setup({
  on_attach = function(c, b)
    ih.on_attach(c, b)
  end,
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

require("lspconfig").terraformls.setup({})
require("lspconfig").tflint.setup({})

require("lspconfig").elixirls.setup({
  cmd = { "elixir-ls" },
  capabilities = capabilities,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})

require("lspconfig").efm.setup({
  capabilities = capabilities,
  filetypes = { "elixir", "ex" },
})
