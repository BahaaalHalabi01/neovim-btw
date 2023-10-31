 local opts = { noremap = true, silent = true, desc = '' }
 opts.desc = "diagnostic_jump_prev"
 vim.keymap.set('n', '[d', function()
 require("trouble").next({skip_groups = true, jump = true});
 end, opts)
 opts.desc = "lspsaga diagnostic_jump_next"
 vim.keymap.set('n', ']d', function()
 require("trouble").next({skip_groups = true, jump = true});
 end,opts)
 opts.desc = 'trouble open'
 vim.keymap.set("n", ";x", function() require("trouble").open() end,opts)
 opts.desc = 'diagnostic workspace'
 vim.keymap.set("n", ";w", function() require("trouble").open("workspace_diagnostics") end,opts)
 opts.desc = 'diagnostic document'
 vim.keymap.set("n", ";e", function() require("trouble").open("document_diagnostics") end,opts)
 opts.desc = 'quick fix'
 vim.keymap.set("n", "<leader>la", function() require("trouble").open("quickfix") end,opts)
 opts.desc = 'location list'
 vim.keymap.set("n", "<leader>lx", function() require("trouble").open("loclist") end,opts)
 opts.desc = 'go references'
 vim.keymap.set("n", "gr", function() require("trouble").open("lsp_references") end,opts)
 vim.keymap.set("n", "gd", function() vim.lsp.buf.declaration() end,opts)
 vim.keymap.set("n", "<C-c>","<Cmd>TroubleClose<Cr>",opts)
