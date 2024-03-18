local M = {}

local ls = require("luasnip")

ls.config.set_config({
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true,
})

ls.filetype_extend("elixir", { "html" })
ls.filetype_extend("eelixir", { "html" })
ls.filetype_extend("heex", { "html" })

function M.navigate(num)
  if ls.jumpable(num) then
    ls.jump(num)
  end
end

return M
