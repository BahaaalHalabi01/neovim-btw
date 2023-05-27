local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettierd.with({
      bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
      filetypes = {
        "svelte",
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
      },
    }),
  }
}

vim.keymap.set("n", "<leader>li", "<CR>:NullLsInfo<CR>", { desc = "lsp info" })
