local filetypes = {
    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'tsx', 'jsx',
    'xml',
    'markdown',
}

require('nvim-ts-autotag').setup({
  filetypes = filetypes,
})
