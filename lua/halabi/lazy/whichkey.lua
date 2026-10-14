return {
"folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 400
      require("which-key").setup {}
    end
}
