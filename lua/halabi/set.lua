local opt = vim.opt -- to set options

-- vim.cmd("autocmd!")

opt.guicursor =
"n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.o.pumwidth = 8

opt.nu = true
opt.relativenumber = true
-- undo tree add later
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/./undodir"

opt.undofile = true

vim.completeopt = 'menuone,noselect'
vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.clipboard = "unnamedplus"
opt.updatetime = 50
opt.timeoutlen = 300  -- The time before a key sequence should complete
opt.splitright = true -- Put new windows right of current
opt.colorcolumn = "80"
vim.g.mapleader = " "
opt.title = true
opt.autoindent = true
opt.smartindent = true
opt.hlsearch = true
-- opt.incsearch = true
opt.backup = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.expandtab = true
opt.scrolloff = 8
opt.inccommand = 'split'
-- opt.ignorecase =false-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smarttab = true
opt.breakindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.wrap = false          -- No Wrap lines
opt.backspace = { 'start', 'eol', 'indent' }
-- opt.path:append { '**' }  -- Finding files - Search down into subfolders
opt.cpoptions:append(">") -- when you yank multiple times into a register, this puts each on a new line
opt.wildignore:append { '*/node_modules/*' }


-- Add asterisks in block comments
opt.formatoptions:append { 'r' }

-- [[ Highlight on yank ]]
-- See `:help .highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})




