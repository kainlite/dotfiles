local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- =====================
  -- UI STUFF
  -- =====================

  -- Top buffer/tab line
  {
    "akinsho/nvim-bufferline.lua",
    after = "catppuccin",
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = { "", "" },
          tab_size = 22,
          enforce_regular_tabs = true,
          view = "multiwindow",
          show_buffer_close_icons = true,
          diagnostics = "nvim_lsp",
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function() end,
  },

  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<Leader>tt]],
        insert_mappings = false,
      })
    end,
  },

  {
    "catppuccin/nvim",
    as = "catppuccin",
  },
  -- Git in the gutter
  "lewis6991/gitsigns.nvim",
  -- dev-icons
  "kyazdani42/nvim-web-devicons",

  -- auto-indent
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  -- statusline
  { "feline-nvim/feline.nvim" },
  -- Code actions ui thingy
  "hood/popui.nvim",
  -- lsp progress thingy
  { "j-hui/fidget.nvim", tag = "legacy" },
  -- startup screen
  "mhinz/vim-startify",

  -- =====================
  -- TELESCOPE
  -- =====================
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
  },
  {
    "romgrk/fzy-lua-native",
    dependencies = { { "nvim-telescope/telescope.nvim" } },
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    dependencies = { { "nvim-telescope/telescope.nvim" } },
  },

  -- =====================
  -- lsp stuff
  -- =====================
  -- lsp stuff
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer",
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.diagnostics.eslint,
        },
      })
    end,
  },

  -- completion plugin
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Fancy autocompletion icons
  { "onsails/lspkind.nvim" },

  -- snips
  "L3MON4D3/LuaSnip",

  "JoosepAlviste/nvim-ts-context-commentstring",

  -- tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/playground",

  "windwp/nvim-ts-autotag",
  "p00f/nvim-ts-rainbow",

  -- Lua dev
  "folke/lua-dev.nvim",
  "ckipp01/stylua-nvim",
  -- flutter
  "akinsho/flutter-tools.nvim",
  -- ts
  "jose-elias-alvarez/typescript.nvim",
  -- rust
  "simrat39/rust-tools.nvim",
  "simrat39/inlay-hints.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  -- Debugging
  "mfussenegger/nvim-dap",
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

  -- =====================
  -- OTHERS
  -- =====================
  -- Pairs ()
  "windwp/nvim-autopairs",
  -- which key
  "anuvyklack/hydra.nvim",
  -- git
  "tpope/vim-fugitive",
  -- file trees
  "kyazdani42/nvim-tree.lua",
  -- surround
  "tpope/vim-surround",
  -- Comment stuff out
  "tpope/vim-commentary",
  -- Set root directory properly
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  },
  -- Dev goodies
  "tpope/vim-scriptease",

  -- Faster stuff lol
  "lewis6991/impatient.nvim",

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- formatter
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          javascriptreact = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = {
                  vim.api.nvim_buf_get_name(0),
                },
              }
            end,
          },
          javascript = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                },
                stdin = true,
              }
            end,
          },
          css = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  },

  -- git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },

  -- Project
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/Webs/*",
      },
      last_session_on_startup = true,
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
})
