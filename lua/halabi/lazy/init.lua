return {
  "onsails/lspkind.nvim",
  "kdheepak/lazygit.nvim",
  "kyazdani42/nvim-web-devicons",
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
        disable_inline_completion = false, -- disables inline completion for use with cmp`
        disable_keymaps = false,           -- disables built in keymaps for more manual control
      })
    end,
  },
  "tpope/vim-fugitive",
  'nvim-telescope/telescope-ui-select.nvim',
  "folke/which-key.nvim",
  "laytan/cloak.nvim",
}
