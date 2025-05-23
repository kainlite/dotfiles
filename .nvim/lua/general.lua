vim.g.mapleader = ","

vim.opt.syntax = "enable"

-- line wrapping sux
vim.opt.wrap = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.ruler = true
vim.opt.cmdheight = 1
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.conceallevel = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.background = "dark"
vim.opt.showtabline = 4
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.formatoptions:remove("cro")
-- vim.opt.clipboard = "unnamedplus"
vim.opt.autochdir = true
vim.opt.termguicolors = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = "120"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.shortmess:append("cI")

vim.opt.list = false
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.opt.laststatus = 3

vim.opt.undofile = true

-- disable editorconfig support
vim.g.editorconfig_enable = false

-- nvim-ts-context-commetstring
vim.g.skip_ts_context_commentstring_module = true

vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.signcolumn = "no"
