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

require("lazy").setup("halabi.lazy")

--[[
require("lazy").setup({
   "akinsho/toggleterm.nvim",
    'wakatime/vim-wakatime',
    {"folke/trouble.nvim",config = function()
      -- TODO icons
      require("trouble").setup{
        icons = false
      }
    end
    },
 "Shatur/neovim-session-manager",
 'dinhhuy258/git.nvim' 
},{

  })

--    'nvim-lua/plenary.nvim' ,
--    'onsails/lspkind-nvim',
--    'hrsh7th/cmp-buffer',
--    'hrsh7th/cmp-nvim-lsp',
--    'hrsh7th/nvim-cmp',
--    'neovim/nvim-lspconfig',
--    'jidn/vim-dbml',
--    'williamboman/mason.nvim',
--   'VonHeikemen/lsp-zero.nvim',
--   'williamboman/mason-lspconfig.nvim',
--         'williamboman/mason.nvim',
-- 'sbdchd/neoformat',
--     'nvim-treesitter/nvim-treesitter',
-- "nvim-treesitter/nvim-treesitter-context",
-- "nvim-treesitter/playground",
-- 'theprimeagen/harpoon',
--   'nvim-telescope/telescope-file-browser.nvim',
--   'nvim-telescope/telescope.nvim',
--   'windwp/nvim-autopairs',
--  'windwp/nvim-ts-autotag',
--  'lewis6991/gitsigns.nvim',
-- 'kdheepak/lazygit.nvim',
--]]
