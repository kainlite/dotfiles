return {
  -- plenary is a transitive dep of many plugins; declare explicitly.
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Oil: edit the filesystem like a buffer (replaces nvim-tree as primary).
  -- Press `-` in any buffer to open the parent directory. Edit lines to
  -- rename/move/delete, :w to apply.
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      view_options = { show_hidden = true },
      keymaps = {
        -- Leave window navigation to our global bindings.
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil: open parent dir" },
    },
  },

  -- Snacks: picker, explorer, terminal, notifier, input, bigfile, etc.
  -- Replaces telescope, nvim-tree sidebar, toggleterm, fidget, popui.
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = { enabled = true, ui_select = true },
      explorer = { enabled = true },
      terminal = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys",    gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      -- Snacks loads its sub-modules lazily; touching them here ensures
      -- vim.ui.select/vim.ui.input get wired up at startup.
      vim.schedule(function()
        vim.ui.select = Snacks.picker.select
        vim.ui.input = Snacks.input
      end)
    end,
    keys = {
      -- Picker (replaces telescope)
      { "<leader>ff", function() Snacks.picker.files() end,           desc = "Find files" },
      { "<leader>fg", function() Snacks.picker.grep() end,            desc = "Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end,         desc = "Buffers" },
      { "<leader>fh", function() Snacks.picker.help() end,            desc = "Help" },
      { "<leader>fr", function() Snacks.picker.recent() end,          desc = "Recent files" },
      { "<leader>fs", function() Snacks.picker.lsp_symbols() end,     desc = "Symbols (buffer)" },
      { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Symbols (workspace)" },
      { "<leader>fd", function() Snacks.picker.diagnostics() end,     desc = "Diagnostics" },
      { "<leader>fk", function() Snacks.picker.keymaps() end,         desc = "Keymaps" },
      { "<leader>f/", function() Snacks.picker.lines() end,           desc = "Search in buffer" },
      { "<leader>fw", function() Snacks.picker.grep_word() end,       desc = "Word under cursor" },
      { "<leader>fc", function() Snacks.picker.command_history() end, desc = "Command history" },
      { "<leader>fR", function() Snacks.picker.resume() end,          desc = "Resume last picker" },

      -- Explorer (on-demand sidebar)
      { "<leader>e", function() Snacks.explorer() end, desc = "Explorer toggle" },
      { "<leader>E", function() Snacks.explorer({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Explorer (here)" },

      -- Terminal
      { "<leader>tt", function() Snacks.terminal() end, desc = "Terminal toggle" },
      { "<leader>tg", function() Snacks.terminal("lazygit") end, desc = "Lazygit" },
    },
  },

  -- Surround (cs/ds/ys)
  { "tpope/vim-surround", event = "BufReadPost" },

  -- Comments (Comment.nvim + ts-context-commentstring for heex/jsx)
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("ts_context_commentstring").setup({ enable_autocmd = false })
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Sessions per cwd (keep your current workflow)
  {
    "gennaro-tedesco/nvim-possession",
    lazy = false,
    dependencies = {
      { "tiagovla/scope.nvim", lazy = false, opts = {} },
      "ibhagwan/fzf-lua",
    },
    config = function()
      require("nvim-possession").setup({
        autoload = true,
        autoswitch = { enable = true },
        save_hook = function() vim.cmd("ScopeSaveState") end,
        post_hook = function() vim.cmd("ScopeLoadState") end,
      })
    end,
    keys = {
      { "<C-p>",      function() require("nvim-possession").list() end,   desc = "Session list" },
      { "<leader>sn", function() require("nvim-possession").new() end,    desc = "Session new" },
      { "<leader>su", function() require("nvim-possession").update() end, desc = "Session update" },
      { "<leader>sd", function() require("nvim-possession").delete() end, desc = "Session delete" },
    },
  },

  -- Git gutter (only git plugin we keep)
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
    },
    keys = {
      { "]g",         function() require("gitsigns").nav_hunk("next") end, desc = "Next git hunk" },
      { "[g",         function() require("gitsigns").nav_hunk("prev") end, desc = "Prev git hunk" },
      { "<leader>gp", function() require("gitsigns").preview_hunk() end,   desc = "Preview hunk" },
      { "<leader>gr", function() require("gitsigns").reset_hunk() end,     desc = "Reset hunk" },
      { "<leader>gb", function() require("gitsigns").blame_line() end,     desc = "Blame line" },
      { "<leader>gd", function() require("gitsigns").diffthis() end,       desc = "Diff this" },
    },
  },
}
