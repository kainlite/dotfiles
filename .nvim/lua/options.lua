-- Global helpers kept from previous config
_G.P = function(v)
  print(vim.inspect(v))
  return v
end

_G.RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

_G.R = function(name)
  _G.RELOAD(name)
  return require(name)
end

-- :W -> :w (typo tolerance)
vim.cmd("command! -nargs=0 W :w")

local opt = vim.opt

opt.syntax = "enable"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.number = true
opt.cursorline = true
opt.background = "dark"
opt.showtabline = 2
opt.ruler = true
opt.cmdheight = 1
opt.laststatus = 3
opt.signcolumn = "yes"
opt.termguicolors = true
opt.textwidth = 120
opt.colorcolumn = "120"

opt.wrap = false
opt.mouse = "a"
opt.mousemoveevent = true
opt.splitbelow = true
opt.splitright = true
opt.conceallevel = 0
opt.updatetime = 300
opt.timeoutlen = 500
opt.autoread = true
opt.autochdir = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.smarttab = true
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.completeopt = "menuone,noinsert,noselect"

opt.iskeyword:append("-")
opt.formatoptions:remove("cro")
opt.shortmess:append("cI")

opt.list = false
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

opt.undofile = true

opt.sessionoptions = {
  "buffers",
  "tabpages",
  "globals",
  "curdir",
  "winsize",
  "winpos",
  "help",
  "folds",
}

vim.g.editorconfig_enable = false
