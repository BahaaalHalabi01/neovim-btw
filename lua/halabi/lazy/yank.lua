return {
  "svban/YankAssassin.nvim",
  config = function()
    require("YankAssassin").setup {
      auto_normal = true,
      auto_visual = true,
    }
  end,
}
