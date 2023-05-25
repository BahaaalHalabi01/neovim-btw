local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
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
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end,{desc="find files"})
vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end,{desc="live grep"})
vim.keymap.set('n', ';\\', function()
  builtin.buffers()
end,{desc = "current buffers"})
vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end,{desc=" help tags"})
vim.keymap.set('n', ';;', function()
  builtin.resume()
end,{desc="resume"})
vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end,{desc = "diagnostics"})
vim.keymap.set("n", "<leader>pv", function()

  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
        winblend = 10,
  })
end,{desc = "file browser"})
