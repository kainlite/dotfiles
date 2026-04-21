local map = vim.keymap.set

-- ============================================================================
-- Window navigation (normal + terminal) -- fixes Claude Code terminal UX
-- ============================================================================
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Terminal mode: double-Esc exits to normal, single-Esc stays in the TUI
-- so Claude Code's Esc still reaches claude.
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Terminal: exit to normal mode" })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal: window left" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal: window down" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal: window up" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal: window right" })

-- ============================================================================
-- Buffer navigation
-- ============================================================================
map("n", "<TAB>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Prev buffer" })
map("n", "<S-l>", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer right" })
map("n", "<S-h>", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer left" })
map("n", "<leader>q", ":bd<CR>", { silent = true, desc = "Close buffer" })

map("n", "qq", function()
  require("utils.smartquit")()
  vim.cmd("bprevious")
end, { desc = "Smart quit" })

-- ============================================================================
-- Editing
-- ============================================================================
map("n", "<Esc>", ":noh<CR><Esc>", { silent = true, desc = "Clear search highlight" })

map("i", "<C-u>", "<Esc>viwUi", { desc = "Uppercase current word" })

-- Keep visual selection after indent.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Swap lines with Alt-j/k (was C-j/k, freed up for window nav).
map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Swap line down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Swap line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Duplicate current line (preserves cursor position).
map("n", "<C-d>", "mzyyp`z", { desc = "Duplicate line" })

-- Yank whole buffer to system clipboard.
map({ "n", "v" }, "<C-c>", ":%y+<CR>", { silent = true, desc = "Yank buffer to clipboard" })

-- Delete previous word while in insert.
map("i", "<C-BS>", "<C-\\><C-o>db", { desc = "Delete prev word" })

-- F1 as Esc (preserves previous habit).
map({ "n", "i", "v", "s" }, "<F1>", "<Esc>")

-- ============================================================================
-- Diagnostics (native 0.11+ API)
-- ============================================================================
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "ge", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "gE", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic float" })

-- ============================================================================
-- UI toggles  (<leader>u*)
-- ============================================================================
map("n", "<leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, { desc = "Toggle inlay hints" })

map("n", "<leader>ul", function()
  local cur = vim.diagnostic.config() or {}
  local new = not cur.virtual_lines
  vim.diagnostic.config({ virtual_lines = new, virtual_text = not new })
end, { desc = "Toggle virtual_lines" })

map("n", "<leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

map("n", "<leader>us", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle listchars" })

map("n", "<leader>un", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

-- ============================================================================
-- Elixir/Phoenix gettext helpers (visual mode) -- preserved from previous config
-- ============================================================================
map("v", "<leader>xg", 'ygvc<%= gettext "<C-r>0" %><Esc>', { desc = "Gettext: <%= %>" })
map("v", "<leader>xh", 'ygvc{ gettext <C-r>0 }<Esc>', { desc = "Gettext: { }" })
map("v", "<leader>xf", "ygvc gettext(<C-r>0)<Esc>", { desc = "Gettext: fn call" })
