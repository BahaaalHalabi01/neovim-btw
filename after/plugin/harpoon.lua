local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha",mark.add_file,{desc ='harpoon mark'})
vim.keymap.set("n", "<C-q>",ui.toggle_quick_menu, {desc = 'harpoon ui'})

vim.keymap.set("n", "<leader>hw", function() ui.nav_file(1) end,{desc = 'harpoon 2 file'})
vim.keymap.set("n", "<leader>he", function() ui.nav_file(2) end,{desc = 'harpoon 3 file'})
vim.keymap.set("n", "<leader>hr", function() ui.nav_file(3) end,{desc = 'harpoon 4 file'})
