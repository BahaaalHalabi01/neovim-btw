return {
  "neovim/nvim-lspconfig",
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
  },

  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      lsp_capabilities,
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
    vim.keymap.set("n", "<leader>w", function() vim.diagnostic.open_float() end)
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end)
    vim.keymap.set({ "i", "n" }, "<C-h>", function() vim.lsp.buf.signature_help() end)
    vim.keymap.set("n", "<leader>lca", function()
      vim.lsp.buf.code_action()
    end)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      callback = function()
        vim.cmd([[Trouble qflist open]])
      end,
    })
  end,
}
