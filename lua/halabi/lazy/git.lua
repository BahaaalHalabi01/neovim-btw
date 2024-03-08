return {
"dinhhuy258/git.nvim", 
  config = function()
local git = require("git")

vim.keymap.set("n","<leader>gg",vim.cmd.LazyGit);
git.setup({
  keymaps = {
    -- Open blame window
    blame = "<Leader>gb",
    -- Open file/folder in git repository
    browse = "<Leader>go",
  }
}) 
  end
}
