-----------------------
-- Rust
-----------------------
vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        procMacro = { enable = true },
        diagnostics = {
          disabled = { "unresolved-proc-macro", "unresolved-macro-call", "unlinked-file", },
        },
        enableExperimental = {
          procAttrMacros = true,
        },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
