return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = false,
    priority = 100,
    config = false,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local cmp = require('cmp')

      require "halabi.snippets"

      cmp.setup({
        sources = {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'path',     priority = 250 },
          { name = "buffer",   priority = 500 },
          { name = 'luasnip',  priority = 700 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item { select = true },
          ["<C-p>"] = cmp.mapping.select_prev_item { select = true },
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              select = true,
            },
            { "i", "c" }
          ),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),

        formatting = {
          -- fields = { 'abbr', 'kind', 'menu', },
          format = require('lspkind').cmp_format({
            maxheight = 500,
            preset = 'default',
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            -- mode = 'true',         -- show only symbol annotations
            maxwidth = 300,        -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            -- menu = ({
            --   nvim_lsp = "[LSP]",
            --   buffer = "[Buffer]",
            --   luasnip = "[LuaSnip]",
            -- })
          }),
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        vim.diagnostic.config({
          update_in_insert = true,
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
        -- vim.keymap.set("n", "<leader>.", function() vim.diagnostic.open_float() end)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end)
        vim.keymap.set({ "i", "n" }, "<C-h>", function() vim.lsp.buf.signature_help() end)
        vim.keymap.set("n", "<leader>la", function()
          vim.lsp.buf.code_action()
        end)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        -- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format" })
        vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = 'format' })

        vim.keymap.set("n", "<leader>.", function()
          vim.diagnostic.open_float(0, {
            scope = "cursor",
            focusable = true,
            close_events = {
              "CursorMoved",
              "CursorMovedI",
              "BufHidden",
              "InsertCharPre",
              "WinLeave",
            },
          })
        end, { desc = 'open float' })

        vim.api.nvim_create_autocmd("QuickFixCmdPost", {
          callback = function()
            vim.cmd([[Trouble qflist open]])
          end,
        })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })



      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "tsserver",
          "rust_analyzer"
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
          end,
          --  ['svelte'] = function()
          --   local capabilities_svelte = capabilities
          --    capabilities_svelte.workspace.didChangeWatchedFiles.dynamicRegistration = true
          --    local lspconfig = require("lspconfig")
          --    lspconfig.svelte.setup {
          --      capabilities =capabilities_svelte ,
          --    }
          --  end,
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,
          ['rust_analyzer'] = function()
            local lspconfig = require("lspconfig")
            lspconfig.rust_analyzer.setup {
              settings = {
                ['rust_analyzer'] = {
                  checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                      'cargo', 'clippy', '--workspace', '--message-format=json',
                      '--all-targets', '--all-features'
                    }
                  }
                }
              }
            }
          end,
        }
      })
    end,
  }
}
