local cmp = require("cmp")

local compare = require("cmp.config.compare")

local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 75,
      ellipsis_char = "...",
      symbol_map = { Copilot = "" },
    }),
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-b>"] = cmp.mapping.abort(),
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping.confirm({
      -- this is the important line
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    -- { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "emoji", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "nvim_lsp_signature_help", group_index = 2 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      -- require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})
