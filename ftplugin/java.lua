-- Some Config Path
local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local config_dir = jdtls_dir .. '/config_linux'
local plugin_dir = jdtls_dir .. '/plugins/'
local jar_dir = plugin_dir .. 'org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
local lombok_path = jdtls_dir .. '/lombok.jar'
-- Project Data config
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/nvim-java-workspace-data/' .. project_name
os.execute("mkdir " .. workspace_dir)
-- Root config
local root_marker = { ".git", "nvnw", "gradlew", "pom.xml", "bundle.gradle" }
local root_dir_path = require("jdtls.setup").find_root(root_marker)
if root_dir_path == "" then
  return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. lombok_path,
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', jar_dir,
    '-configuration', config_dir,
    '-data', workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = root_dir_path,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      home = "/usr/lib/jvm/default",
      project = {
        encoding = "UTF-8",
      },
      errors = {
        incompleteClasspath = {
          severity = "warning"
        }
      },
      trace = {
        server = "verbose"
      },
      import = {
        enabled = true,
        gradle = {
          enabled = true
        },
        maven = {
          enabled = true
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**"
        },
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      saveActions = {
        organizeImports = true
      },
      contentProvider = {
        preferred = "fernflower"
      },
      autobuild = {
        enabled = false
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "org.graalvm.*",
          "jdk.*",
          "sun.*",
        },
      },
      configuration = {
        -- updateBuildConfiguration = "interactive",
        maven = {
          userSettings = vim.fn.expand("~/.m2/settings.xml"),
          globalSettings = vim.fn.expand("~/.m2/settings.xml"),
        },
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/",
            default = true
          },
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk/",
            -- default = true
          },
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk/",
            -- default = true
          },
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      bundles = {},
      extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>Telescope lsp_document_symbols<cr>", opts)
  --vim.api.nvim_buf_set_keymap(
  --  bufnr,
  --  "n",
  --  "gl",
  --  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
  --  opts
  --)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  --自动导入全部缺失的包，自动删除多余的未用到的包
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>go", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
  -- 代码保存自动格式化formatting
  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
end

config['on_attach'] = function(client, bufnr)
  lsp_keymaps(bufnr);
end

local cache_vars = {}
if cache_vars.capabilities == nil then
  require("jdtls").extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  cache_vars.capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    ok_cmp and cmp_lsp.default_capabilities() or {}
  )
end
config['capabilities'] = cache_vars.capabilities

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
