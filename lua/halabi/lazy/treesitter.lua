return {
 'nvim-treesitter/nvim-treesitter',
   build = ":TSUpdate",
  opts = {
  },

   config = function ()
local status, ts = pcall(require, "nvim-treesitter.configs")
 if (not status) then return end

 ts.setup {
   modules = {},
   auto_install = true,
   ignore_install = {  },
   sync_install = false,
   highlight = {
     enable = true,
     additional_vim_regex_highlighting = false,
   },
   indent = {
     enable = true,
     disable = {},
   },
   ensure_installed = {
     "markdown",
     "markdown_inline",
     "typescript",
     "javascript",
     "json",
     "yaml",
     "css",
     "html",
   },
   context_commentstring = {
     enable         = true,
     enable_autocmd = true,
   },
   move = {
     enable = true,
     set_jumps = true, -- whether to set jumps in the jumplist
     goto_next_start = {
       [']m'] = '@function.outer',
       [']]'] = '@class.outer',
     },
     goto_next_end = {
       [']M'] = '@function.outer',
       [']['] = '@class.outer',
     },
     goto_previous_start = {
       ['[m'] = '@function.outer',
       ['[['] = '@class.outer',
     },
     goto_previous_end = {
       ['[M'] = '@function.outer',
       ['[]'] = '@class.outer',
     },
   },
   swap = {
     enable = true,
     swap_next = {
       ['<leader>a'] = '@parameter.inner',
     },
     swap_previous = {
       ['<leader>A'] = '@parameter.inner',
     },
   },
   textobjects = {
     select = {
       enable = true,
       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
       keymaps = {
         -- You can use the capture groups defined in textobjects.scm
         ['aa'] = '@parameter.outer',
         ['ia'] = '@parameter.inner',
         ['af'] = '@function.outer',
         ['if'] = '@function.inner',
         ['ac'] = '@class.outer',
         ['ic'] = '@class.inner',
       },
     }
   },
   incremental_selection = {
     enable = true,
     keymaps = {
       init_selection = '<c-space>',
       node_incremental = '<c-space>',
       scope_incremental = '<c-s>',
       node_decremental = '<M-space>',
     },
   },
 }
   end
  
}
