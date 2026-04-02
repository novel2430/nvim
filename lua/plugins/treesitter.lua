local need_filetype = {
  'c',
  'javascript',
  'lua',
  'markdown',
  'vim',
  'python',
  'cpp',
  'java',
  'javadoc',
  'typescript',
  'jsx',
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
require('nvim-treesitter').install(need_filetype)

-- Auto Enable Highlight
vim.api.nvim_create_autocmd('FileType', {
  pattern = need_filetype,
  callback = function() vim.treesitter.start() end,
})
