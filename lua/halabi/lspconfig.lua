local status, cmp = pcall(require, "cmp")
if (not status) then return end
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
local lsp = require('lsp-zero').preset({})
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end
local protocol = require('vim.lsp.protocol')


lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()



lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false,desc='lsp'}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
  -- client.resolved_capabilities.document_formatting = false
  vim.keymap.set('n', '<space>lf', function()
    vim.lsp.buf.format { async = true }
  end, { buffer = bufnr, desc = "[L]anguage [F]ormat" })
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim_lsp.svelte.setup {
--   on_attach = on_attach,
--   filetypes = { "svelte" },
--   cmd = { "svelteserver", "--stdio" },
--   root_dir = util.root_pattern('package.json', '.git'),
--   capabilities = capabilities
-- }
nvim_lsp.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "javascript" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}

-- nvim_lsp.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }


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

-- nvim_lsp.tailwindcss.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }

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

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },

  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item(cmp_select_opts)
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item(cmp_select_opts)
      else
        cmp.complete()
      end
    end),
  },
  -- snippet = {
  --   expand = function(args)
  --     require('luasnip').lsp_expand(args.body)
  --   end,
  -- },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- formatting = {
  -- fields = {'abbr', 'menu', 'kind'},
  -- format = function(entry, item)
  --   local short_name = {
  --     nvim_lsp = 'LSP',
  --     nvim_lua = 'nvim',
  --     buffer = 'file'
  --   }
  --   local menu_name = short_name[entry.source.name] or entry.source.name
  --   item.menu = string.format('[%s]', menu_name)
  --   return item
  -- end,
  -- },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = require('lspkind').cmp_format({
      preset = 'default',
      mode = 'true',         -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    })
  }
})


local status, colors = pcall(require, "lsp-colors")
if (not status) then return end

colors.setup {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
}

-- is this even working?
protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

vim.diagnostic.config({
    virtual_text = true
})
