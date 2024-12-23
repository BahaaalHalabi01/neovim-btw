return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        typescript = {
          "biome"
        },
        typescriptreact = {
          "biome"
        },
        javascript = {
          "biome"
        },
        javascriptreact = {
          "biome"
        }
      }

      vim.keymap.set("n", "<leader>ll", function()
        local lint_status, l = pcall(require, "lint")
        if lint_status then
          l.try_lint()
        end
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  }
  ,
  {

  }
}
