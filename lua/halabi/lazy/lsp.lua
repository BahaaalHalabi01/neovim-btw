return {
  "neovim/nvim-lspconfig",
  lazy = false,
  priority = 100,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      -- lsp_capabilities,
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "cssls",
        "tsserver",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
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
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        ["eslint"] = function()
          local capabilities_lint = capabilities
          capabilities_lint.workspace.documentFormattingProvider = false
          local lspconfig = require("lspconfig")
          lspconfig.eslint.setup {
            capabilities = capabilities_lint,
          }
        end,
        ['rust_analyzer'] = function()
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
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
        --
        -- ["gopls"] = function()
        --    local lspconfig = require("lspconfig")
        --    lspconfig.gopls.setup {
        --      capabilities = capabilities,
        --     cmd = {"gopls"},
        --     filetypes = {"go","gomod","gowork","gotmpl"},
        --   }
        --
        -- end,
      }
    })

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


    require "halabi.snippets"

    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.shortmess:append "c"

    local lspkind = require "lspkind"
    lspkind.init {}
    local cmp = require "cmp"

    cmp.setup {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
      },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { select = true },
        ["<C-p>"] = cmp.mapping.select_prev_item { select = true },
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            select = true,
          },
          { "i", "c" }
        ),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
      },
      formatting = {
        fields = { 'abbr', 'kind', 'menu', },
        format = require('lspkind').cmp_format({
          maxheight = 500,
          preset = 'default',
          mode = 'true',         -- show only symbol annotations
          maxwidth = 300,        -- prevent the popup from showing more than provided characters
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            luasnip = "[LuaSnip]",
          })
        }),
      },
      -- Enable luasnip to handle snippet expansion for nvim-cmp
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
    }

    vim.keymap.set("n", "<leader>ai", "<Cmd>SupermavenToggle<Cr>")

    -- gray
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
    -- blue
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
    -- light blue
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
    -- pink
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
    -- front
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
  end,
}
