return {
  -- Colorscheme (must load first so everything else themes correctly)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1100,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = false,
        integrations = {
          bufferline = true,
          gitsigns = true,
          mason = true,
          native_lsp = { enabled = true },
          treesitter = true,
          which_key = true,
          snacks = { enabled = true },
          blink_cmp = true,
          indent_blankline = { enabled = true },
          dap = true,
          dap_ui = true,
          markdown = true,
          notify = true,
          semantic_tokens = true,
          telescope = { enabled = false },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Icons for file types (shared by bufferline, oil, snacks pickers)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Buffer/tab line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        separator_style = { "", "" },
        tab_size = 22,
        enforce_regular_tabs = true,
        show_buffer_close_icons = true,
        diagnostics = "nvim_lsp",
      },
    },
  },

  -- Statusline (replaces feline)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "" end
              local names = {}
              for _, c in ipairs(clients) do table.insert(names, c.name) end
              return " " .. table.concat(names, ",")
            end,
          },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Discoverability for leader keys
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "modern" },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>a", group = "AI/Claude" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Session" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI Toggle" },
        { "<leader>x", group = "Elixir helpers" },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
    },
  },

  -- Inline color preview (#f3f3f3, rgb(), etc.)
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        user_default_options = { rgb_fn = true, hsl_fn = true, css = true },
      })
    end,
  },

  -- Highlight TODO/FIXME/HACK/NOTE comments
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
    },
  },
}
