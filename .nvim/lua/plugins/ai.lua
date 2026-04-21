return {
  -- Claude Code integration.
  -- Uses snacks.nvim terminal: right-split, 38% wide, vertical diffs.
  -- All keybindings live under <leader>a* and are grouped via which-key.
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    lazy = false,
    opts = {
      terminal = {
        provider = "snacks",
        split_side = "right",
        split_width_percentage = 0.38,
        auto_close = true,
      },
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
        keep_terminal_focus = false,
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>",              desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",         desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",     desc = "Resume" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",   desc = "Continue" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",   desc = "Select model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",         desc = "Add current buffer" },
      {
        "<leader>aB",
        function()
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then
              local name = vim.api.nvim_buf_get_name(b)
              if name ~= "" and vim.fn.filereadable(name) == 1 then
                vim.cmd("ClaudeCodeAdd " .. vim.fn.fnameescape(name))
              end
            end
          end
        end,
        desc = "Add all listed buffers",
      },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",          mode = "v",       desc = "Send selection" },
      { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>",       ft = { "oil" },   desc = "Add file under cursor" },
      { "<leader>ap", "vip<cmd>ClaudeCodeSend<cr>",                         desc = "Send paragraph" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",                      desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",                        desc = "Deny diff" },
    },
  },
}
