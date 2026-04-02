vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    require('plugins.LSP.attach')(event)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Server Configuration
local lsp_servers = require('plugins.LSP.lsp-servers-config')

for server_name, server_config in pairs(lsp_servers) do
  server_config.capabilities = capabilities
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end

-- Mason Install lsp servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})
