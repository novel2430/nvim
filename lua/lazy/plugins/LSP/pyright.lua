return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        diagnosticMode = "workspace",
      },
    },
  },
}
