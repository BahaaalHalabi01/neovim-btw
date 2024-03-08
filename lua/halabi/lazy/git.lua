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

--
-- @todo i do not like fugitive, read more about how to use it
-- return {
-- "tpope/vim-fugitive",
-- config = function()
--
--   local Fugitive = vim.api.nvim_create_augroup("Fugitive", {})
--
--         local autocmd = vim.api.nvim_create_autocmd
--         autocmd("BufWinEnter", {
--             group = Fugitive,
--             pattern = "*",
--             callback = function()
--                 if vim.bo.ft ~= "fugitive" then
--                     return
--                 end
--
--                 local bufnr = vim.api.nvim_get_current_buf()
--                 local opts = {buffer = bufnr, remap = false}
--                 vim.keymap.set("n", "<leader>p", function()
--                     vim.cmd.Git('push')
--                 end, opts)
--
--                 -- rebase always
--                 vim.keymap.set("n", "<leader>P", function()
--                     vim.cmd.Git({'pull',  ''})
--                 end, opts)
--
--                 -- NOTE: It allows me to easily set the branch i am pushing and any tracking
--                 -- needed if i did not set the branch up correctly
--                 vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
--             end,
--         })
--         vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
--         vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
--         vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
--
--   end
--
-- }
