local need_filetype = {
  'c',
  'javascript',
  'lua',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'python',
  'cpp',
  'java',
  'javadoc',
  'typescript',
  'tsx',
  'json',
  'cmake',
  'ninja',
  'html',
  'yaml',
  'toml',
  'bash',
  'nix',
}

require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

local alreadyInstalled = require('nvim-treesitter.config').get_installed()
local parsersToInstall = vim.iter(need_filetype)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()
require('nvim-treesitter').install(parsersToInstall)


-- Auto Enable Highlight
vim.api.nvim_create_autocmd('FileType', {
  pattern = need_filetype,
  callback = function()
    -- Enable treesitter highlighting and disable regex syntax
    pcall(vim.treesitter.start)
    -- Enable treesitter-based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
