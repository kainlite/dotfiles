return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local languages = {
        "bash", "c", "cpp", "css", "diff", "dockerfile",
        "eex", "elixir", "erlang", "gitcommit", "gitignore",
        "go", "graphql", "hcl", "heex", "html",
        "javascript", "json", "lua",
        "make", "markdown", "markdown_inline",
        "python", "query", "regex", "rust",
        "solidity", "sql", "terraform", "toml",
        "tsx", "typescript", "vim", "vimdoc", "yaml", "zig",
      }

      pcall(function()
        require("nvim-treesitter").install(languages)
      end)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
