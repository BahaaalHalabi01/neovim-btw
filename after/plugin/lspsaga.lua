local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
  ui = {
    border = 'rounded',
  },
  symbol_in_winbar = {
    enable = false
  }
})

local diagnostic = require("lspsaga.diagnostic")
local opts = { noremap = true, silent = true, desc = 'lspsaga commands' }
vim.keymap.set('n', '<C-m>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<leader>q', '<Cmd>Lspsaga show_buf_diagnostics ++unfocus<CR>', opts)
vim.keymap.set('n', '<leader>e', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', ops)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
