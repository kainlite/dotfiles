require("plugins")
require("impatient")
require("globals")
require("general")
require("mappings")
require("statusline")

require("config/compe")
require("config/dashboard-nvim")
require("config/diagnostics")
require("config/fidget")
require("config/flutter-tools")
require("config/gitsigns")
require("config/hydra")
require("config/indent-blankline")
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

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
  integration = {
    nvimtree = {
      enabled = true,
      show_root = false, -- makes the root folder not transparent
      transparent_panel = true, -- make the panel transparent
    },
  },
})
vim.cmd([[colorscheme catppuccin]])
