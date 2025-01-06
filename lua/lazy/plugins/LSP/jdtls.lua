local util = require 'lspconfig.util'
-- Some Config Path
local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local config_dir = jdtls_dir .. '/config_mac_arm'
local plugin_dir = jdtls_dir .. '/plugins/'
local jar_dir = vim.fn.globpath(plugin_dir, 'org.eclipse.equinox.launcher_*.jar')
local lombok_path = jdtls_dir .. '/lombok.jar'
local data_dir = vim.fn.stdpath('data') .. '/nvim-java-workspace-data/'
local root_files = {
  -- Single-module projects
  {
    'build.xml',           -- Ant
    'pom.xml',             -- Maven
    'settings.gradle',     -- Gradle
    'settings.gradle.kts', -- Gradle
  },
  -- Multi-module projects
  { 'build.gradle', 'build.gradle.kts' },
}

function check_dir_exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      return true
    end
  end
  return ok
end

function make_dir()
  if not check_dir_exists(data_dir) then
    os.execute("mkdir " .. data_dir)
  end
end

local getroot = function(fname)
  for _, patterns in ipairs(root_files) do
    local root = util.root_pattern(unpack(patterns))(fname)
    if root then
      return root
    end
  end
end

function getroot_val(fname)
  for _, patterns in ipairs(root_files) do
    local root = util.root_pattern(unpack(patterns))(fname)
    if root then
      return root
    end
  end
end

-- Make Package Data dir
make_dir()

return {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    '/opt/homebrew/Cellar/openjdk@21/21.0.4/bin/java', -- or '/path/to/java17_or_newer/bin/java'
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
    '-data', data_dir
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = getroot(fname),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      home = "/opt/homebrew/Cellar/openjdk@21/21.0.4/",
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
  },
}
