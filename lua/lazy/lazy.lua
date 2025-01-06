require('lazy').setup({
  -- Treesitter --
  require('lazy.plugins.treesitter').config,
  -- LSP --
  require('lazy.plugins.lsp').config,
  -- Cmp --
  require('lazy.plugins.cmp').config,
  -- Telescope --
  require('lazy.plugins.telescope').config,
  -- Comment --
  require('lazy.plugins.comment').config,
  -- AutoPairs --
  require('lazy.plugins.autopairs').config,
  -- Blank Line --
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- opts = {
    -- }
    config = function()
      -- insert all the code from: https://github.com/lukas-reineke/indent-blankline.nvim#multiple-indent-colors
      local highlight = {
        "GRAY",
      }
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "GRAY", { fg = "#5A5A5A" })
      end)
      require("ibl").setup { indent = { highlight = highlight } }
    end
  },
  -- Vscode Color --
  require('lazy.plugins.vscode-colorscheme').config,
  -- Rust Tool --
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  -- Markdown Preview --
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
})
