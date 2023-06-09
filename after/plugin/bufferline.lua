local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            themable = true,
            numbers =  "ordinal",
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style =  'underline'
            },
            modified_icon = '●',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = true, -- whether or not tab names should be truncated
            tab_size = 18,
            diagnostics = "nvim_lsp" ,
            diagnostics_update_in_insert = false,
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "["..count.."]"
            end,
            -- NOTE: this will be called a lot so don't do any heavy processing here
            color_icons = true, -- whether or not to add the filetype icon highlights
            get_element_icon = function(element)
              -- element consists of {filetype: string, path: string, extension: string, directory: string}
              -- This can be used to change how bufferline fetches the icon
              -- for an element e.g. a buffer or a tab.
              -- e.g.
              local hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = true})
              return hl
            end,
            show_buffer_icons = true, -- disable filetype icons for buffers
            show_buffer_close_icons = false,
            show_close_icon =  false,
            show_tab_indicators = true ,
            show_duplicate_prefix = true , -- whether to show duplicate buffer prefix
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            separator_style =  "thin" ,
            enforce_regular_tabs = true,
            always_show_bufferline = true ,
            sort_by = 'id'
        },
 
})
vim.opt.termguicolors = true
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
vim.keymap.set("n","<leader>bd","<Cmd>:%bd|e#<CR>",{desc = "close all buffers except current"})
vim.keymap.set("n","<leader>c","<Cmd>:bn|bd#<CR>",{desc = "close buffer"})
