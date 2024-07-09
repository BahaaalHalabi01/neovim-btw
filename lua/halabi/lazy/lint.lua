return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = {
        "eslint"
      },
      typescript = {
        "eslint"
      },
      javascriptreact = {
        "eslint"
      },
      typescriptreact = {
        "eslint"
      }
    }

    vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
      callback = function()
        local lint_status, l= pcall(require, "lint")
        if lint_status then
          l.try_lint()
        end
      end,
    })


    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
