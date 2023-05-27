local status, lspkind = pcall(require, "lspkind")
if (not status) then return end
-- isn't working still
-- local codicons = require('codicons')
-- codicons.setup({})

lspkind.init({
  -- enables text annotations
  -- default: true
  mode = 'text_symbol',
  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  -- default: 'default'
  -- make codicons work later
  preset = 'default',
  -- override preset symbols
  --
  -- default: {}
})

