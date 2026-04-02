local highlight = {
  "GRAY",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "GRAY", { fg = "#5A5A5A" })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#FFFFFF" })
end)

require("ibl").setup {
  indent = { highlight = highlight },
  scope = {
    enabled = true,             -- Enable scope highlighting
    show_start = false,         -- Show an underline on the first line of the scope
    show_end = false,           -- Show an underline on the last line of the scope
    highlight = { "IblScope" }, -- The highlight group to use
  },
}
