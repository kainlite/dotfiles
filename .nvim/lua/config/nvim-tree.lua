require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_root = false,
    update_cwd = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  sync_root_with_cwd = true,
})
