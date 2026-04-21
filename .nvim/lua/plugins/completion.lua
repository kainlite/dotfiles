return {
  -- Copilot as a background suggestion provider for blink.cmp
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ["."] = true,
      },
    },
  },

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
  -- Default keymap: Tab/S-Tab next/prev, CR accept, C-Space trigger, C-e abort.
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "fang2hou/blink-copilot",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = { border = "rounded", draw = { treesitter = { "lsp" } } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
          window = { border = "rounded" },
        },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "copilot", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
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
