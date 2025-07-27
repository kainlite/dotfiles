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
    dependencies = "catppuccin/nvim",
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
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup()
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
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
  },
  -- Git in the gutter
  "lewis6991/gitsigns.nvim",
  -- dev-icons
  -- "kyazdani42/nvim-web-devicons",

  -- auto-indent
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  -- statusline
  { "feline-nvim/feline.nvim" },
  -- Code actions ui thingy
  "hood/popui.nvim",
  -- lsp progress thingy
  { "j-hui/fidget.nvim", tag = "legacy" },

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
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer",

  -- completion plugin
  {
    "hrsh7th/nvim-cmp",
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  "hrsh7th/cmp-cmdline",
  { "nvim-neotest/nvim-nio" },
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
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Fancy autocompletion icons
  { "onsails/lspkind.nvim" },

  -- snips
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/playground",

  -- Lua dev
  "folke/lua-dev.nvim",
  "ckipp01/stylua-nvim",

  -- rust
  {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
},
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
  -- Dev goodies
  "tpope/vim-scriptease",

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
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "claude",
      auto_suggestions_provider = "claude",
      providers = {
        openai = {
          model = "gpt-4o",
          api_key = os.getenv("OPENAI_API_KEY"),
        },
        anthropic = {
          model = "claude-3-5-sonnet-20241022",
          api_key = os.getenv("ANTHROPIC_API_KEY"),
        },
        google = {
          model = "gemini-2.0-flash-thinking-exp-1219",
          api_key = os.getenv("GOOGLE_API_KEY"),
        },
      },
      hints = { enabled = false },
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = false,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    "brendalf/mix.nvim",
    config = function()
      require("mix").setup()
    end,
  },

  {
    "tiagovla/scope.nvim",
    lazy = false,
    config = true,
    event = "VeryLazy",
  },
  {
    "gennaro-tedesco/nvim-possession",
    lazy = false,
    dependencies = {
      {
        "tiagovla/scope.nvim",
        lazy = false,
        config = true,
      },
      "ibhagwan/fzf-lua",
    },
    config = function()
      require("nvim-possession").setup({
        autoload = true,
        autoswitch = {
          enable = true,
        },
        save_hook = function()
          vim.cmd([[ScopeSaveState]]) -- Scope.nvim saving
        end,
        post_hook = function()
          vim.cmd([[ScopeLoadState]]) -- Scope.nvim loading
        end,
      })
    end,
  },
})
