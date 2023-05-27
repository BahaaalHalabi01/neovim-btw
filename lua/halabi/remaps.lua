local keymap = vim.keymap

-- i love this thank you
keymap.set('n', 'x', '"_x',{desc = "delete and don't yank"})
keymap.set('v', 'x', '"_x',{desc = "delete and don't yank"})

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Split window
keymap.set("n", "<C-\\>", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

vim.g.mapleader = " "

vim.keymap.set("n", "<C-\\>", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

vim.keymap.set("n", "<C-h>", '<C-W>h', { desc = 'left window' })
vim.keymap.set("n", "<C-l>", '<C-W>l', { desc = 'right window' })
vim.keymap.set("n", "<C-s>", "<Cmd>w!<CR><Esc>", { desc = "save" })
vim.keymap.set("i", "<C-s>", "<Cmd>w!<CR><Esc>", { desc = " save insert" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "past without yank" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- use telescope for now
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
-- { desc = 'search and replace under cursor' })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
