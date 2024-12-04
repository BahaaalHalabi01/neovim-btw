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
          { name = 'nvim_lsp', priority = 1200 },
          { name = 'luasnip',  priority = 700 },
          { name = "buffer",   priority = 500 },
          { name = 'path',     priority = 250 },
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
            maxheight = 200,
            mode = 'symbol',
            preset = 'default',
            show_labelDetails = false, -- show labelDetails in menu. Disabled by default
            -- mode = 'true',         -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50,           -- leading text (labelDetails)
              abbr = 50,           -- actual suggestion item
            },
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              luasnip = "[LuaSnip]",
            })
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
      "j-hui/fidget.nvim",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.3", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta",             lazy = true },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      if vim.g.obsidian then
        return
      end


      local lsp_attach = function(client, bufnr)
        vim.diagnostic.config({
          -- update_in_insert = true,
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "definition", buffer = 0 })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "hover", buffer = 0 })
        -- vim.keymap.set("n", "<leader>.", function() vim.diagnostic.open_float() end)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "rename", buffer = 0 })
        vim.keymap.set({ "i", "n" }, "<C-h>", function() vim.lsp.buf.signature_help() end,
          { desc = "signature help", buffer = 0 })
        vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end,
          { desc = "code action", buffer = 0 })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "goto next", buffer = 0 })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "goto prev", buffer = 0 })
        -- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format" })
        vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
          { desc = 'format', buffer = 0 })

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
        end, { desc = 'open float diagnostic', buffer = 0 })

        -- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        --   callback = function()
        --     vim.cmd([[Trouble qflist open]])
        --   end,
        --
        -- })
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            -- Here use ctx.match instead of ctx.file
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end


      local cmp_lsp = require("cmp_nvim_lsp")
      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        lsp_capabilities,
        cmp_lsp.default_capabilities())

      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          -- "rust_analyzer"
        },
        handlers = {
          function(server_name) -- default handler (optional)
            if server_name == "rust_analyzer" then
              print("rust_analyzer")
            else
              require("lspconfig")[server_name].setup {}
            end
          end,
          -- ['svelte'] = function()
          --   local capabilities_svelte = capabilities
          --   capabilities_svelte.workspace.didChangeWatchedFiles.dynamicRegistration = true
          --   local lspconfig = require("lspconfig")
          --   lspconfig.svelte.setup {
          --     capabilities = capabilities_svelte,
          --   }
          -- end,
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
          -- ['rust_analyzer'] = function()
          --   local lspconfig = require("lspconfig")
          --   lspconfig.rust_analyzer.setup {
          --     checkOnSave = {
          --       command = "clippy",
          --     },
          --   }
          -- end,

          ['ts_ls'] = function()
            local lspconfig = require("lspconfig")
            capabilities.documentFormattingProvider = false
            lspconfig.tsserver.setup {
              capabilities = capabilities,
              settings = {
                tsserver = {
                  enable = true,
                  tsserverPath = "typescript-language-server",
                }
              }
            }
          end,
        }
      })
    end,
  }
}
