local builtin_state, builtin = check_state('telescope.builtin')
if not builtin_state then
  return
end
local action_state, action = check_state('telescope.actions')
if not action_state then
  return
end
local tele_tabs_state, tabs = check_state('telescope.actions')
if not tele_tabs_state then
  return
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fo', function ()
  local opts = {
    grep_open_files = true,
    prompt_title = 'Search in Open Files',
  }
  builtin.live_grep(opts)
end, {})
vim.keymap.set('n', '<leader>fn', function ()
  local opts = {
    search_dirs={vim.fn.expand("%:p")},
    prompt_title = 'Search in Current Files',
  }
  builtin.live_grep(opts)
end, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {})
vim.keymap.set('n', '<leader>fs', builtin.search_history, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    prompt_prefix = "> ",
    selection_caret = "> ",
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = action.move_selection_next,
        ["<C-k>"] = action.move_selection_previous,
        ["<Down>"] = action.move_selection_next,
        ["<Up>"] = action.move_selection_previous,
        ["<Tab>"] = action.move_selection_previous,
        ["<CR>"] = action.select_default,
        ["<C-q>"] = action.close,
        ["<ESC>"] = action.close,
      },
      n = {
        ["<C-h>"] = "which_key",
        ["j"] = action.move_selection_next,
        ["k"] = action.move_selection_previous,
        ["<Down>"] = action.move_selection_next,
        ["<Up>"] = action.move_selection_previous,
        ["<Tab>"] = action.move_selection_previous,
        ["<CR>"] = action.select_default,
        ["<C-q>"] = action.close,
        ["<ESC>"] = action.close,
      }

    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    live_grep = {
      -- disable_devicons = true,
      theme = "dropdown"
    },
    buffers = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
    },
    search_history = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
    },
    command_history = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
    },
    lsp_references = {
      -- disable_devicons = true,
      theme = "dropdown",
    },

  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
