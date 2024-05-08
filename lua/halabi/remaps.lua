local keymap = vim.keymap

vim.keymap.set('n', '<leader>lp', '<Cmd>:Neoformat<CR>', { desc = "[P]retier" })
--
-- i love this thank you
keymap.set('n', 'x', '"_x', { desc = "delete and don't yank" })
keymap.set('v', 'x', '"_x', { desc = "delete and don't yank" })

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

keymap.set('n', '<C-n>', '')

keymap.set('n', 'db', 'vb"_di', { desc = "Delete a word backwards and enter insert" })
keymap.set('n', 'dw', 'vw"_di', { desc = "Delete a word infront and enter insert" })


vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Git toggle line blame" })
vim.g.mapleader = " "

vim.keymap.set("n", "<C-\\>", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-s>", "<Cmd>w!<CR><Esc>", { desc = "save" })
vim.keymap.set("i", "<C-s>", "<Cmd>w!<CR><Esc>", { desc = " save insert" })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "y", "y0<Esc>", { desc = "Yank and reposition cursor" })

vim.keymap.set("n", "<esc>", function()
  local function close_floating()
    for _, win in pairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative == "win" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })


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

vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'search and replace under cursor' })

vim.keymap.set('v', "<C-r>", [[y<ESC>:%s@\<<C-r><C-w>\>@<C-r><C-w>@gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)


-- These two keep the search in the middle of the screen.
vim.keymap.set("n", "n", function()
  vim.cmd("silent normal! nzz")
end)

vim.keymap.set("n", "N", function()
  vim.cmd("silent normal! Nzz")
end)

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format" })


vim.keymap.set({ "n", "x" }, "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
vim.keymap.set({ "n", "x" }, "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste Below" })
vim.keymap.set({ "n" }, "<leader>g", '<Cmd>Ex<Cr>', { desc = "explorer" })

-- buffers, maybe just write and run command ?
vim.keymap.set("n", "<leader>d",'<cmd>bd<CR>', { desc = "delete buffer" })
vim.keymap.set("n", "<leader>bp",'<cmd>bp<CR>', { desc = "previous buffer" })
vim.keymap.set("n", "<leader>bn",'<cmd>bn<CR>', { desc = "next buffer" })
