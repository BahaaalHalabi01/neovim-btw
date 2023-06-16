local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({

})

local opts = { noremap = true, silent = true, desc = '' }
opts.desc = "lspsaga diagnostic_jump_prev"
vim.keymap.set('n', '[d', function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
opts.desc = "lspsaga diagnostic_jump_next"
vim.keymap.set('n', ']d', function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)
opts.desc = "lspsaga show_buf_diagnostics"
vim.keymap.set('n', '<leader>q', '<Cmd>Lspsaga show_buf_diagnostics ++unfocus<CR>', opts)
opts.desc = "lspsaga show_line_diagnostics"
vim.keymap.set('n', '<leader>e', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
opts.desc = "lspsaga hover"
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
opts.desc = "lspsaga lspfinder"
-- i do not like using this
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>', opts)
opts.desc = "lspsaga signature_help"
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
opts.desc = "lspsaga peek defination"
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
opts.desc = "lspsaga rename"
vim.keymap.set('n', '<leader>lr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
