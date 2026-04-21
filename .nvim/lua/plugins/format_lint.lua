return {
  -- Formatter (replaces formatter.nvim / stylua-nvim)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua            = { "stylua" },
        elixir         = { "mix_format" },
        heex           = { "mix_format" },
        eelixir        = { "mix_format" },
        python         = { "ruff_format", "ruff_organize_imports" },
        rust           = { "rustfmt" },
        go             = { "gofmt" },
        terraform      = { "terraform_fmt" },
        tf             = { "terraform_fmt" },
        hcl            = { "terraform_fmt" },
        solidity       = { "forge_fmt" },
        javascript     = { "prettierd", "prettier", stop_after_first = true },
        typescript     = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        svelte         = { "prettierd", "prettier", stop_after_first = true },
        css            = { "prettierd", "prettier", stop_after_first = true },
        html           = { "prettierd", "prettier", stop_after_first = true },
        json           = { "prettierd", "prettier", stop_after_first = true },
        yaml           = { "prettierd", "prettier", stop_after_first = true },
        markdown       = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 3000, lsp_format = "fallback" }
      end,
    },
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = { "n", "v" }, desc = "Format buffer" },
      {
        "<leader>cF",
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("Format on save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
        end,
        desc = "Toggle format-on-save",
      },
    },
  },

  -- Linters
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      require("lint").linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        elixir          = { "credo" },
      }
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        callback = function()
          pcall(require("lint").try_lint)
        end,
      })
    end,
  },
}
