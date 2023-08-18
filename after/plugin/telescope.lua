local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")
local trouble = require("trouble.providers.telescope")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["q"] = actions.close,
        ["cd"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          local dir = vim.fn.fnamemodify(selection.path, ":p:h")
          require("telescope.actions").close(prompt_bufnr)
          -- Depending on what you want put `cd`, `lcd`, `tcd`
          vim.cmd(string.format("silent lcd %s", dir))
        end
      },
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<C-u>"] = false
      },
    },
    file_ignore_patterns = {
      "node%_modules/.*",
      ".git/*",
      "public/*",
      "yarn.lock"
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["%"] = fb_actions.create,
          ["-"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

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
-- vim.keymap.set('n', ';e', function()
  -- builtin.diagnostics({ bufnr = 0 })
-- end, { desc = "diagnostics" })
vim.keymap.set("n", "<leader>pv", function()
  vim.keymap.set("n", "<leader>m", function()
    builtin.marks()
  end, { desc = "Browse Marks" })

  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = false,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
    winblend = 10,
  })
end, { desc = "file browser" })
