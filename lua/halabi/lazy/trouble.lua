return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>ed",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>ts",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>tl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>tL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>tQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
  -- "folke/trouble.nvim",
  --
  -- config = function()
  --   local trbl = require("trouble")
  --
  --   trbl.setup({
  --     severity = vim.diagnostic.severity.ERROR,
  --     padding = false,
  --     auto_close = true,
  --     use_diagnostic_signs = true
  --   })
  --
  --
  --   local opts = { noremap = true, silent = true, desc = '' }
  --   opts.desc = "diagnostic_jump_prev"
  --   vim.keymap.set('n', '<leader>r', function()
  --     require("trouble").next({ skip_groups = true, jump = true, });
  --   end, opts)
  --   opts.desc = "diagnostic_jump_next"
  --   vim.keymap.set('n', '<leader>p', function()
  --     require("trouble").next({ skip_groups = true, jump = true });
  --   end, opts)
  --   opts.desc = 'trouble '
  --   vim.keymap.set("n", "<leader>tt","<Cmd>TroubleToggle<Cr>", opts)
  --   opts.desc = 'diagnostic workspace'
  --   vim.keymap.set("n", "<leader>ew", function() require("trouble").open("workspace_diagnostics") end, opts)
  --   opts.desc = 'diagnostic document'
  --   vim.keymap.set("n", "<leader>ed", function() require("trouble").open("document_diagnostics") end, opts)
  --   opts.desc = 'quick fix'
  --   vim.keymap.set("n", "<leader>la", function() require("trouble").open("quickfix") end, opts)
  --   opts.desc = 'location list'
  --   vim.keymap.set("n", "<leader>lx", function() require("trouble").open("loclist") end, opts)
  --   opts.desc = 'go references'
  --   vim.keymap.set("n", "gr", function() require("trouble").open("lsp_references") end, opts)
  --   opts.desc = 'go type definations'
  --   vim.keymap.set("n", "gt", function() require("trouble").open("lsp_type_definitions") end, opts)
  --   opts.desc = 'go declartions'
  --   vim.keymap.set("n", "gd", function() require("trouble").open("lsp_definitions") end, opts)
  --   vim.keymap.set("n", "<C-c>", "<Cmd>TroubleClose<Cr>", opts)
  -- end,

