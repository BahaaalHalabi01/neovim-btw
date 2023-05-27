local prettier = require("prettier")

prettier.setup({
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
  cli_options = {
    -- add global here later
    -- arrow_parens = "always",
    -- embedded_language_formatting = "auto",
    -- end_of_line = "auto",
    -- html_whitespace_sensitivity = "css",
    -- print_width = 80,
    -- quote_props = "as-needed",
    -- semi = true,
    -- single_attribute_per_line = true,
    -- single_quote = false,
    -- tab_width = 3,
    -- trailing_comma = "es5",
    -- use_tabs = true,
    -- bracket_same_line = false
  },
})

vim.keymap.set('n', '<leader>lp', '<CR>:Prettier<CR>', { desc = "[P]retier" })
