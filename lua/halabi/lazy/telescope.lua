return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "plenary"
  },

  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local action_layout = require("telescope.actions.layout")
    local open_with_trouble = require("trouble.sources.telescope").open

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      },
      defaults = {
        layout_strategy = "flex",
        mappings = {
          n = {
            ["<M-p>"] = action_layout.toggle_preview,
            ["<c-t>"] = open_with_trouble
          },
          i = {
            ["<C-u>"] = false,
            ["<c-t>"] = open_with_trouble,
            ["<M-p>"] = action_layout.toggle_preview
          },
        },
        file_ignore_patterns = {
          "node%_modules/.*",
          ".git/*",
          ".dist/*",
          "target/*",
          "*.lock",

        },
      }
    }
    )


    vim.keymap.set('n', '<leader>fw',
      function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end)
    vim.keymap.set('n', '<leader>F',
      function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
      end)
    vim.keymap.set("n", "<leader>q", function() builtin.marks() end, { desc = 'builtin marks' })
    vim.keymap.set('n', '<leader>eg', builtin.git_files, { desc = "git files" })
    vim.keymap.set('n', '<leader>ef', function() builtin.find_files({ hidden = false }) end, { desc = "find files" })
    vim.keymap.set('n', '<leader>eh', function() builtin.find_files({ hidden = true }) end,
      { desc = "find hidden files" })
    vim.keymap.set('n', '<leader>el', function() builtin.live_grep() end, { desc = "live grep" })
    vim.keymap.set('n', '<leader>er', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end,
      { desc = "grep string" })
    vim.keymap.set('n', '<leader>eb', function() builtin.buffers() end, { desc = "current buffers" })
    -- vim.keymap.set('n', '<leader>eh', function() builtin.help_tags() end, { desc = " help tags" })
    vim.keymap.set('n', '<leader>ee', function() builtin.resume() end, { desc = "resume" })
    vim.keymap.set('n', '<leader>ls', function() builtin.lsp_document_symbols() end, { desc = "symbols" })
    vim.keymap.set("n", "<leader>lw", function() builtin.lsp_workspace_symbols() end, { desc = 'workspace symbol' })

    require("telescope").load_extension("ui-select")
  end

}
