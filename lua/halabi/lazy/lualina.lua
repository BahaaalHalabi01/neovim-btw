return {
  'nvim-lualine/lualine.nvim',
  config = function(_, opts)
    function search_cnt()
      local res = vim.fn.searchcount({ maxcount = 1000, timeout = 500 })

      if res.total > 0 then
        return string.format("%s/%d %s", res.current, res.total, vim.fn.getreg('/'))
      else
        return ""
      end
    end

    local lualine = require("lualine")

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = {
          { 'mode', padding = 2 },
          'branch',
        },
        lualine_b = {
          { 'diagnostics',
            sources = { "nvim_diagnostic" },
            symbols = { error = ' ', warn = ' ', info = 'I',
              hint = ' ' }
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = true,  -- displays file status (readonly status, modified status)
            path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
            padding = 1

          }
        },
        lualine_x = { { 'searchcount', search_cnt, maxcount = 999, timeout = 500 } },
        lualine_y = {},
        lualine_z = { 'filetype' },
      },
    }
  end

}
