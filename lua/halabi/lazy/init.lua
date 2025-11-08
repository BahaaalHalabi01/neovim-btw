return {
  -- 'ryanoasis/vim-devicons',
  -- 'mortepau/codicons.nvim',
  -- "folke/tokyonight.nvim",
  -- "MunifTanjim/nui.nvim",
  -- "tpope/vim-fugitive",
  { "sbdchd/neoformat",                            lazy = false },
  { 'wakatime/vim-wakatime',                       lazy = false },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
  { "nvim-lua/plenary.nvim",                       name = "plenary" },
  'nvim-telescope/telescope-ui-select.nvim',
  "folke/which-key.nvim",
  "laytan/cloak.nvim",
  -- { 'augmentcode/augment.vim' },
  {
    'echasnovski/mini.surround',
    branch = 'stable',
    main = 'mini.surround',
    opts = {
      search_method = 'cover_or_next',
    }
  }
}
