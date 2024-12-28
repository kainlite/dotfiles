require("plugins")
require("globals")
require("general")
require("mappings")
require("statusline")

require("config/cmp")
require("config/ai")
require("config/diagnostics")
require("config/fidget")
require("config/gitsigns")
require("config/hydra")
require("config/lspconfig")
require("config/luasnip")
require("config/nvim-autopairs")
require("config/nvim-dap-ui")
require("config/nvim-tree")
require("config/nvim-ts-autotag")
require("config/rust-tools")
require("config/symbols-outline")
require("config/telescope")
require("config/tree-sitter")
require("config/typescript")
require("config/ui")
require("config/scope")

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
  integration = {
    nvimtree = {
      enabled = true,
      show_root = true, -- makes the root folder not transparent
      transparent_panel = true, -- make the panel transparent
    },
    bufferline = true,
  },
})
vim.cmd([[colorscheme catppuccin]])
