return {
  cmd = { "rust-analyzer" },
  filetypes = { 'rust' },
  single_file_support = true,
  root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}
