local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- use('xiyaowong/transparent.nvim')
  use("akinsho/toggleterm.nvim")
  -- use({ 'rose-pine/neovim', as = 'rose-pine' })
  use { "ellisonleao/gruvbox.nvim" }
  use 'wakatime/vim-wakatime'
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim'     -- Common utilities
  use 'onsails/lspkind-nvim'      -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'        -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'      -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'          -- Completion
  use 'neovim/nvim-lspconfig'     -- LSP
  use 'jidn/vim-dbml'             -- dbml
  use 'williamboman/mason.nvim'
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        'williamboman/mason.nvim',
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },                  -- Required
      { 'hrsh7th/cmp-nvim-lsp' },              -- Required
      { 'L3MON4D3/LuaSnip' },                  -- Required
    }
  }
  use({
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  })
  use('MunifTanjim/prettier.nvim')
  use 'williamboman/mason-lspconfig.nvim'
  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.0.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  })
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 400
      require("which-key").setup {}
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end, }
  use("nvim-treesitter/nvim-treesitter-context")
  use("nvim-treesitter/playground")
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'mortepau/codicons.nvim'
  use('theprimeagen/harpoon')
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'folke/zen-mode.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'

  use 'lewis6991/gitsigns.nvim'
  use('kdheepak/lazygit.nvim')
  use("Shatur/neovim-session-manager");
  use 'dinhhuy258/git.nvim' -- For git blame & browse
end)
