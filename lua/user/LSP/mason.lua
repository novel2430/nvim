
local servers = {
  "lua_ls",
  "clangd",
  "pyright",
  "volar",
  "jdtls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "I",
			package_pending = "P",
			package_uninstalled = "U",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
  if server ~= 'jdtls' then
    opts = {
      on_attach = require("user.LSP.handlers").on_attach,
      capabilities = require("user.LSP.handlers").capabilities,
    }
    server = vim.split(server, "@")[1]
    local require_ok, conf_opts = pcall(require, "user.LSP.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
    lspconfig[server].setup(opts)
  end
end
