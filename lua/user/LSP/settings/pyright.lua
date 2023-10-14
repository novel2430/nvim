return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        diagnosticMode = "workspace",
        -- stubPath = vim.fn.stdpath("config") .. "/stubs",
        extraPaths = {
          -- vim.fn.stdpath("config") .. "/python",
          "~/.local/lib/python3.11/"
        },
      },
    }
  }
}
