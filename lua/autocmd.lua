-- Open File Jump To Last Postition
vim.cmd([[
  augroup RestoreCursor
    autocmd!
    autocmd BufRead * autocmd FileType <buffer> ++once
      \ let s:line = line("'\"")
      \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase'], &filetype) == -1
      \ |   execute "normal! g`\""
      \ | endif
  augroup END
]])

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Build <luasnip> plugind
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if name == 'luasnip' and (kind == 'install' or kind == 'update') then
      local result = vim.system(
        { 'make', 'install_jsregexp' },
        { cwd = ev.data.path }
      ):wait()
      if result.code ~= 0 then
        vim.notify(
          ('LuaSnip build failed: %s'):format(result.stderr or 'unknown error'),
          vim.log.levels.ERROR
        )
      end
    end
  end,
})
