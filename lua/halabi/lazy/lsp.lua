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
            maxheight = 500,
            preset = 'default',
            show_labelDetails = false, -- show labelDetails in menu. Disabled by default
            -- mode = 'true',         -- show only symbol annotations
            maxwidth = 300,            -- prevent the popup from showing more than provided characters
            ellipsis_char = '...',     -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
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
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      local lsp_attach = function(client, bufnr)
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

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "definition", buffer = bufnr })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "hover", buffer = bufnr })
        -- vim.keymap.set("n", "<leader>.", function() vim.diagnostic.open_float() end)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "rename", buffer = bufnr })
        vim.keymap.set({ "i", "n" }, "<C-h>", function() vim.lsp.buf.signature_help() end,
          { desc = "signature help", buffer = bufnr })
        vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end,
          { desc = "code action", buffer = bufnr })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "goto next", buffer = bufnr })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "goto prev", buffer = bufnr })
        -- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format" })
        vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
          { desc = 'format', buffer = bufnr })

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
        end, { desc = 'open float diagnostic', buffer = bufnr })

        -- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        --   callback = function()
        --     vim.cmd([[Trouble qflist open]])
        --   end,
        -- })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })



      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- "cssls",
          -- "tsserver",
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
            -- local lspconfig = require("lspconfig")
            -- lspconfig.rust_analyzer.setup {
            --   settings = {
            --     ['rust_analyzer'] = {
            --       checkOnSave = {
            --         allFeatures = true,
            --       }
            --     }
            --   }
            -- }
          end,
        }
      })

      vim.g.rustaceanvim = {
        server = {
          cmd = function()
            local mason_registry = require('mason-registry')
            local ra_binary = mason_registry.is_installed('rust-analyzer')
                -- This may need to be tweaked, depending on the operating system.
                and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
                or "rust-analyzer"
            return { ra_binary } -- You can add args to the list, such as '--log-file'
          end,
        },
      }

      vim.g.rustaceanvim = {
        tools = {
          -- ...
        },
        server = {
          on_attach = function(client, bufnr)
            -- Set keybindings, etc. here.
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
            },
          },
          -- ...
        },
        dap = {
          -- ...
        },
      }
    end,
  }
}
