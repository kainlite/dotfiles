-- Leader keys must be set before lazy loads plugins that bind leader mappings.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Disable netrw early so oil.nvim can take over file:// URIs.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Faster startup: cache compiled Lua modules.
vim.loader.enable()

require("options")
require("autocmds")
require("keymaps")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  change_detection = { notify = false },
  install = { colorscheme = { "catppuccin" } },
  rocks = { enabled = false },
  ui = { border = "rounded" },
})
