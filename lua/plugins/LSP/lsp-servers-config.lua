return {
  clangd = {},
  -- rust_analyzer = require("lazy.plugins.LSP.rust_analyzer"),
  pyright = {
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
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" }, },
        workspace = {
          library = {
            library = vim.api.nvim_get_runtime_file("", true),
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = '@vue/typescript-plugin',
              location = vim.fn.stdpath('data') ..
                  "/mason/packages/vue-language-server/node_modules/@vue/language-server",
              languages = { 'vue' },
              configNamespace = 'typescript',
            },
          },
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  vue_ls = {},
  jdtls = require("plugins.LSP.jdtls"),
}
