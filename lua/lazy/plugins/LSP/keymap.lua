local normal = function(event)
  local bufnr = event.buf
  local opts = { noremap = true, silent = true }
  local map = function(key, command)
    vim.api.nvim_buf_set_keymap(bufnr, "n", key, command, opts)
  end
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  map("gd", "<cmd>Telescope lsp_definitions<CR>")
  map("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map("gi", "<cmd>Telescope lsp_implementations<CR>")
  map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map("gr", "<cmd>Telescope lsp_references<CR>")
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  map("[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
  map("gl", "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>")
  map("<leader>d", "<cmd>Telescope lsp_document_symbols<cr>")
  map("]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
  map("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
end

local java = function(event)
  local bufnr = event.buf
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
end

return function(event, client)
  if client == 'jdtls' then
    java(event)
  else
    normal(event)
  end
end
