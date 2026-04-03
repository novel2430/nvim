local opts = { remap = false, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ==== BASIC KEYMAP SETUP ====
-- Disable highlight
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
-- Comment Toggle
keymap("n", "<C-\\>\\", "gcc", { remap = true, silent = true })
keymap("v", "<C-\\>\\", "gc", { remap = true, silent = true })
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>e", ":Lex 20<cr>", opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-Left>", ":bnext<CR>", opts)
keymap("n", "<S-Right>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
-- Insert Mode navigation
keymap("i", "<C-w>", "<ESC>", opts)
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-l>", "<Right>", opts)
keymap("i", "<A-f>", "<S-Right>", opts)
keymap("i", "<A-b>", "<S-Left>", opts)
keymap("i", "<A-a>", "<Home>", opts)
keymap("i", "<A-z>", "<End>", opts)
keymap("i", "<A-o", "<ESC>o", opts)
keymap("i", "<A-g>", "<ESC>ggi", opts)
keymap("i", "<A-G>", "<ESC>Gi", opts)
-- Undo & Redo in INSERT MODE
keymap("i", "<C-u>", "<ESC>:undo<CR>i", opts)
keymap("i", "<C-r>", "<ESC>:redo<CR>i", opts)
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- Visual Block --
-- Move text up and down
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- Terminal --
-- Better terminal navigation
keymap("n", "<Leader>t", ":belowright 10split<CR>:term zsh<CR>i", opts)
keymap("t", "<Leader>t", "<C-\\><C-n>:bdelete!<CR>", term_opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)
keymap("t", "<C-w>", "<C-\\><C-n>", term_opts)
-- Saving file
keymap("n", "<C-s>", ":wall<CR>", opts)
keymap("i", "<C-s>", "<ESC>:wall<CR>", opts)
-- Copy & Paste & Replace
-- One Line
keymap("n", "yy", "\"ayy", opts)
keymap("n", "<Leader>y", "\"+yy", opts)
keymap("n", "y", "\"ay", opts)
-- Lines
keymap("v", "y", "\"ay", opts)
keymap("v", "<Leader>y", "\"+y", opts)
-- Paste
keymap("n", "p", "\"ap", opts)
keymap("n", "<Leader>p", "\"+p", opts)
-- Replace
keymap("v", "p", "\"_d\"ap", opts)


-- ==== TELESCOPE KEYMAP SETUP ====
local builtin = require 'telescope.builtin'
-- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>fk', builtin.keymaps, opts)
keymap('n', '<leader>ff', builtin.find_files, opts)
-- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
-- vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>fd', builtin.diagnostics, opts)
-- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
keymap('n', '<leader>fr', builtin.oldfiles, opts)
keymap('n', '<leader>fb', builtin.buffers, opts)
keymap('n', '<leader>fn', builtin.current_buffer_fuzzy_find, opts)
keymap('n', "<leader>fs", builtin.lsp_document_symbols, opts)

-- ==== LSP KEYMAP SETUP ====
keymap('n', "gd", builtin.lsp_definitions, opts)
keymap('n', "K", function() vim.lsp.buf.hover({ border = 'rounded' }) end, opts)
keymap('n', "gi", builtin.lsp_implementations, opts)
-- keymap('n', "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap('n', "<leader>rn", vim.lsp.buf.rename, opts)
keymap('n', "gr", builtin.lsp_references, opts)
keymap('n', "gl", function() vim.diagnostic.open_float(nil, { focus = false }) end, opts)
-- keymap('n', "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
keymap('n', "<leader>ca", vim.lsp.buf.code_action, opts)
