local augroup = vim.api.nvim_create_augroup("kainlite", { clear = true })

-- Auto-reload files changed outside nvim. Claude Code edits files from its
-- own process; without this the buffer would show stale content.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }, {
  group = augroup,
  callback = function()
    if vim.fn.mode() ~= "c" and vim.bo.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup,
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO, { title = "autoread" })
  end,
})

-- Terminal tweaks: no line numbers, huge scrollback, start insert.
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.scrollback = 100000
    vim.opt_local.cursorline = false
    vim.cmd("startinsert")
  end,
})

-- Highlight yanked region briefly.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    (vim.hl or vim.highlight).on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Go back to last edit position when opening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, [["]])
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Close some buffer types with q.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "notify" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})
