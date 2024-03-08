local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({spec = "halabi.lazy",change_detection= {notify = false}})




--   'williamboman/mason-lspconfig.nvim',
--         'williamboman/mason.nvim',
--  'lewis6991/gitsigns.nvim',
--]]
