return {
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local ls = require("luasnip")
      ls.filetype_extend("elixir", { "html" })
      ls.filetype_extend("eelixir", { "html" })
      ls.filetype_extend("heex", { "html" })
    end,
  },

  -- blink.cmp: fast completion engine (replaces nvim-cmp + all cmp-* sources).
  -- Keymap: Tab/S-Tab next/prev item (then snippet jump), CR accept,
  -- C-Space trigger, C-e abort.
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = { border = "rounded", draw = { treesitter = { "lsp" } } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
          window = { border = "rounded" },
        },
        -- preselect = false so <CR> inserts a newline unless an item was
        -- explicitly selected with Tab (recommended with the enter preset).
        list = { selection = { preselect = false, auto_insert = false } },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true, window = { border = "rounded" } },
      cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = true },
        },
      },
    },
  },
}
