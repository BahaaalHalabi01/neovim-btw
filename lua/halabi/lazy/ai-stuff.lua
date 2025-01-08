return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-x>",
          accept_word = "<C-a>",
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
          suggestion_color = "#BA4404",
          cterm = 244,
        },
        log_level = "off",          -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,     -- disables built in keymaps for more manual control
        condition = function()
          return false
        end
      })
    end,
  },

}
