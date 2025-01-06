local M = {}
M.config = {
  'Mofiqul/vscode.nvim',
  init = function()
    -- For dark theme (neovim's default)
    vim.o.background = 'dark'
    -- For light theme
    -- vim.o.background = 'light'
    vim.cmd([[colorscheme vscode]])
  end,
  opts = {
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Underline `@markup.link.*` variants
    underline_links = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    color_overrides = {
      vscLineNumber = '#FFFFFF',
    },
  },
  lazy = false,
}
return M
