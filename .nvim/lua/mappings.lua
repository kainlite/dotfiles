local cnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("c", lhs, rhs, { noremap = true, silent = false })
end

local nnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true, silent = silent })
end

local snoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("s", lhs, rhs, { noremap = true, silent = silent })
end

local vnoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- smartquit
nnoremap("qq", '<cmd>lua require("utils/smartquit")()<CR>', true)

-- Escape redraws the screen and removes any search highlighting.
nnoremap("<esc>", ":noh<return><esc>")

-- Easy CAPS
inoremap("<c-u>", "<ESC>viwUi")
-- TAB in normal mode will move to text buffer
nnoremap("<TAB>", ":bnext<CR>")
-- SHIFT-TAB will go back
nnoremap("<S-TAB>", ":bprevious<CR>")

-- Better tabbing
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Swap lines
nnoremap("<c-j>", ":m .+1<CR>==")
nnoremap("<c-k>", ":m .-2<CR>==")
inoremap("<c-j>", "<Esc>:m .+1<CR>==gi")
inoremap("<c-k>", "<Esc>:m .-2<CR>==gi")
vnoremap("<c-j>", ":m '>+1<CR>gv=gv")
vnoremap("<c-k>", ":m '<-2<CR>gv=gv")

--  duplicate line, preserve cursor
nnoremap("<C-d>", "mzyyp`z")

-- Yank directly to the clipboard
map("v", "<C-c>", ":%y+<CR>")
map("n", "<C-c>", ":%y+<CR>")

-- Better window navigation
inoremap("<C-k>", '<cmd>lua require("config/luasnip").navigate(1)<CR>', true)
snoremap("<C-k>", '<cmd>lua require("config/luasnip").navigate(1)<CR>', true)
inoremap("<C-j>", '<cmd>lua require("config/luasnip").navigate(-1)<CR>', true)
snoremap("<C-j>", '<cmd>lua require("config/luasnip").navigate(-1)<CR>', true)

-- Map Ctrl-Backspace to delete the previous word in insert mode.
inoremap("<C-w>", "<C-\\><C-o>dB")
inoremap("<C-BS>", "<C-\\><C-o>db")

-- Symbols Outline
nnoremap("<Leader>s", ":SymbolsOutline<CR>")

-- Comentary
nnoremap("g-c", '<cmd>lua require("utils/comment")()<CR>')
vnoremap("g-c", '<cmd>lua require("utils/comment")()<CR>')

-- Nvim-Tree
nnoremap("<C-n>", ":NvimTreeToggle<CR>")
nnoremap("<leader>r", ":NvimTreeRefresh<CR>")
nnoremap("<leader>n", ":NvimTreeFindFile<CR>")

-- LSP
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", true)
nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", true)
nnoremap("gr", "<cmd>LspTrouble lsp_references<CR>", true)
nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", true)
nnoremap("<C-space>", "<cmd>lua vim.lsp.buf.hover()<CR>", true)
vnoremap("<C-space>", "<cmd>RustHoverRange<CR>")

nnoremap("ge", "<cmd>lua vim.diagnostic.goto_prev()<CR>", true)
nnoremap("gE", "<cmd>lua vim.diagnostic.goto_next()<CR>", true)
nnoremap("<silent><leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
nnoremap("<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", true)
nnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
vnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")

-- Telescope
nnoremap("<C-f>", ':lua require("utils/telescope").search_files()<CR>')
nnoremap("<C-/>", ':lua require("utils/telescope").search_in_buffer()<CR>')
inoremap("<C-f>", '<Esc> :lua require("utils/telescope").search_in_buffer()<CR>')

-- autoformat tf
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = vim.lsp.buf.format,
})

-- handy 
nnoremap("<leader>q", ":bd<CR>")
