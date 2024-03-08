return{
  "folke/tokyonight.nvim",
'kdheepak/lazygit.nvim',
{
  "rose-pine/neovim",
  name= "rose-pine",
  config = function()
    vim.cmd("colorscheme rose-pine")
  end
},
  {"nvim-lua/plenary.nvim",name = "plenary"},

{"folke/trouble.nvim",config = function()
      -- TODO icons
      require("trouble").setup{
        icons = false
      }
    end
    },

  "mbbill/undotree",
  'windwp/nvim-ts-autotag',
  "tpope/vim-fugitive",
    "folke/which-key.nvim",
  "laytan/cloak.nvim",
"eandrju/cellular-automaton.nvim",
 --   'nvim-lualine/lualine.nvim',
}
