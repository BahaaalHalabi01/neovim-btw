return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "plenary"
  },

  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")


    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false
          },
        },
        file_ignore_patterns = {
          "node%_modules/.*",
          ".git/*",
          "*.lock",
          "public/.*"
        }
      },
    })


    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set("n", "<leader>q", function()
      builtin.marks()
    end, { desc = 'builtin marks' })
    vim.keymap.set('n', ';g', builtin.git_files, {})
    vim.keymap.set('n', ';f',
      function()
        builtin.find_files({
          hidden = false
        })
      end, { desc = "find files" })
    vim.keymap.set('n', ';l', function()
      builtin.live_grep()
    end, { desc = "live grep" })
    vim.keymap.set('n', ';r', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "grep string" })
    vim.keymap.set('n', ';\\', function()
      builtin.buffers()
    end, { desc = "current buffers" })
    vim.keymap.set('n', ';t', function()
      builtin.help_tags()
    end, { desc = " help tags" })
    vim.keymap.set('n', ';;', function()
      builtin.resume()
    end, { desc = "resume" })
    vim.keymap.set('n', '<leader>ls', function()
      builtin.lsp_document_symbols()
    end, { desc = "symbols" })
    vim.keymap.set("n", "<leader>lw", function()
      builtin.lsp_workspace_symbols()
    end, { desc = 'workspace symbol' })
  end
}
