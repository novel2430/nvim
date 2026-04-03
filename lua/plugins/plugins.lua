vim.pack.add({
  -- lspconfig
  { src = 'https://github.com/neovim/nvim-lspconfig.git',                   version = 'v2.7.0', },
  -- treesitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',         version = 'v0.10.0', },
  -- [completion] luasnip
  { src = "https://github.com/L3MON4D3/LuaSnip.git",                        version = 'v2.4.1', },
  -- [completion] cmp_luasnip
  { src = "https://github.com/saadparwaiz1/cmp_luasnip.git",                version = 'master', },
  -- [completion] cmp-nvim-lsp
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp.git",                    version = 'main', },
  -- [completion] cmp-path
  { src = "https://github.com/hrsh7th/cmp-path.git",                        version = 'main', },
  -- [completion] cmp core
  { src = "https://github.com/hrsh7th/nvim-cmp.git",                        version = 'v0.0.2', },
  -- [LSP] mason
  { src = 'https://github.com/mason-org/mason.nvim.git',                    version = 'v2.2.1', },
  -- [LSP] mason-lspconfig
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim.git',          version = 'v2.1.0', },
  -- [telescope] plenary
  { src = "https://github.com/nvim-lua/plenary.nvim.git",                   version = 'master', },
  -- [telescope] telescope core
  { src = "https://github.com/nvim-telescope/telescope.nvim.git",           version = 'v0.2.2', },
  -- [telescope] telescope's extension ui select
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git", version = 'master', },
  -- autopairs
  { src = "https://github.com/windwp/nvim-autopairs.git",                   version = '0.10.0', },
  -- indent blankline
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim.git",     version = 'v3.9.1', },
  -- vscode colorscheme
  { src = "https://github.com/Mofiqul/vscode.nvim.git",                     version = 'main', },
  -- live server (md preview's dependency)
  { src = "https://github.com/selimacerbas/live-server.nvim.git",           version = "v1.2.2", },
  -- markdown preview
  { src = "https://github.com/selimacerbas/markdown-preview.nvim.git",      version = 'v1.5.3', },
})

require("plugins.treesitter")
require("plugins.nvim-cmp")
require("plugins.LSP.lsp-core")
require("plugins.telescope")
require("plugins.autopairs")
require("plugins.indent-blankline")
require("plugins.vscode-colorscheme")
require("plugins.markdown-preview")
