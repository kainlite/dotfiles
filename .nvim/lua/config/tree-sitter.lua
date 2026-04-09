-- Languages to install treesitter parsers for
local languages = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "eex",
  "elixir",
  "erlang",
  "gitcommit",
  "gitignore",
  "go",
  "graphql",
  "hcl",
  "heex",
  "html",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "solidity",
  "sql",
  "surface",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zig",
}

-- Install parsers
require("nvim-treesitter").install(languages)

-- Enable treesitter features for all filetypes that have a parser available
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
