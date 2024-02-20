require("nvim-treesitter")

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "cpp",
    "dockerfile",
    "bash",
    "elixir",
    "css",
    "go",
    "javascript",
    "html",
    "go",
    "json",
    "solidity",
    "tsx",
    "markdown",
    "typescript",
    "yaml",
  },

  ts_funky_keywords = { enable = true },
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["property"] = "TSFunction"
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  rainbow = {
    enable = false,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
})
