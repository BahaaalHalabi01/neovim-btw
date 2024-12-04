return {
 'theprimeagen/harpoon',
  config = function()
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha",mark.add_file,{desc ='harpoon mark'})
vim.keymap.set("n", "<C-l>",ui.toggle_quick_menu, {desc = 'harpoon ui'})

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end,{desc = 'harpoon 1 file'})
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end,{desc = 'harpoon 2 file'})
vim.keymap.set("n", "<leader>7", function() ui.nav_file(3) end,{desc = 'harpoon 3 file'})
  end

}
