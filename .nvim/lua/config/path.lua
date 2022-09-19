require("cmp").setup({
  sources = {
    { name = "path" },
  },
})

cmp.setup({
  sources = {
    {
      name = "path",
      option = {
        -- Options go into this table
        trailing_slash = true,
      },
    },
  },
})
