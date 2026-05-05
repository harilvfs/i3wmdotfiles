local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.shfmt.with({
      extra_args = { "-i", "4", "-ci" }, -- Indentation of 4 spaces, continue indentation
    }),
  },
})

