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

require 'nvim-treesitter.configs'.setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  parser_install_dir = vim.fn.stdpath('data') .. '/site',
  ensure_installed = need_filetype,
  auto_install = true,
  sync_install = false,
  ignore_install = {},
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

-- Auto Enable Highlight
vim.api.nvim_create_autocmd('FileType', {
  pattern = need_filetype,
  callback = function() vim.treesitter.start() end,
})
