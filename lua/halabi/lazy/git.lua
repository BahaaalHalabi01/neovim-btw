-- return {
-- "dinhhuy258/git.nvim", 
--   config = function()
-- local git = require("git")
--
-- vim.keymap.set("n","<leader>gg",vim.cmd.LazyGit);
-- git.setup({
--   keymaps = {
--     -- Open blame window
--     blame = "<Leader>gb",
--     -- Open file/folder in git repository
--     browse = "<Leader>go",
--   }
-- }) 
--   end
-- }
--
return {
"tpope/vim-fugitive",
config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")

  end

}
