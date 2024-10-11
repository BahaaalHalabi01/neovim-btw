return {
  'ryanoasis/vim-devicons',
  "kdheepak/lazygit.nvim",
  'mortepau/codicons.nvim',
  "folke/tokyonight.nvim",
  "MunifTanjim/nui.nvim",
  { "sbdchd/neoformat",                            lazy = false },
  { 'wakatime/vim-wakatime',                       lazy = false },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
  { "nvim-lua/plenary.nvim",                       name = "plenary" },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
      })
    end,
  },
  "tpope/vim-fugitive",
  'nvim-telescope/telescope-ui-select.nvim',
  "folke/which-key.nvim",
  "laytan/cloak.nvim",
}
