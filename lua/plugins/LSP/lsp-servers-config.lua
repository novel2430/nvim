return {
  -- C / C++
  clangd = {},
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
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" }, },
        workspace = {
          checkThirdParty = false,
          library = vim.list_extend(
            vim.api.nvim_get_runtime_file("", true),
            { vim.fn.stdpath("config") .. "/lua" }
          ),
        },
        telemetry = { enable = false },
      },
    },
  },
  -- Vue, Typescript, Javascript
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
  -- Vue
  vue_ls = {},
  -- Java
  jdtls = require("plugins.LSP.jdtls"),
}
