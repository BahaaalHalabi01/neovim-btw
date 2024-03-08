local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lsp = require('lsp-zero').preset({})
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end


lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)


 lsp.format_mapping('<leader>lf', {
   format_opts = {
     async = false,
     timeout_ms = 10000,
   },
   servers = {
     ['rust_analyzer'] = { 'rust' },
     ['tsserver'] = { 'javascript', 'typescript','typescriptreact' },
   }
 })

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "javascript" ,"javascriptreact"},
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
}

 -- nvim_lsp.tailwindcss.setup {
 --   capabilities = capabilities
 -- }

 nvim_lsp.rust_analyzer.setup {
   settings = {
     ['rust-analyzer'] = {},
   },
 }

-- nvim_lsp.eslint.setup({})

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}
nvim_lsp.cssls.setup {
  capabilities = capabilities
}


vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    update_in_insert = true,
  }
)


local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<Tab>'] = nil,
  ['<S-Tab>'] = nil,
  ['<C-space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

 lsp.setup_nvim_cmp({

 -- { name = 'buffer', keyword_length = 3 },
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
    autocomplete = false
  },
   mapping = cmp_mappings,
   window = {
     completion = cmp.config.window.bordered(),
     documentation = cmp.config.window.bordered(),

   },
   formatting = {
     fields = { 'abbr', 'kind', 'menu' },
     format = require('lspkind').cmp_format({
       maxheight = 400,
       preset = 'default',
       mode = 'true',         -- show only symbol annotations
       maxwidth = 80,         -- prevent the popup from showing more than provided characters
       ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
     })
   },
  snippet = {
   expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' }
    -- { name = 'buffer' },
  },
 })

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
   error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})


lsp.setup()


lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false, desc = 'lsp' }
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  -- client.resolved_capabilities.document_formatting = false

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
end)

local status, colors = pcall(require, "lsp-colors")
if (not status) then return end

colors.setup {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
}

vim.diagnostic.config({
  virtual_text = true
})
