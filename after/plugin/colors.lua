require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })

-- require('rose-pine').setup({
--     disable_background =false,
-- 	--- @usage 'auto'|'main'|'moon'|'dawn'
-- 	variant = 'main',
-- 	--- @usage 'main'|'moon'|'dawn'
-- 	dark_variant = 'main',
-- 	bold_vert_split =false,
--   dim_nc_background =false,
-- 	disable_float_background =false,
-- 	disable_italics = false,
-- 	--- @usage string hex value or named color from rosepinetheme.com/palette
-- 	groups = {
-- 		background = 'base',
-- 		background_nc = 'base',
-- 		panel = 'base',
-- 		panel_nc = 'base',
-- 		border = 'base',
-- 		comment = 'muted',
-- 		link = 'iris',
-- 		punctuation = 'subtle',
-- 		error = 'love',
-- 		hint = 'iris',
-- 		info = 'foam',
-- 		warn = 'gold',
--
-- 		headings = {
-- 			h1 = 'iris',
-- 			h2 = 'foam',
-- 			h3 = 'rose',
-- 			h4 = 'gold',
-- 			h5 = 'pine',
-- 			h6 = 'foam',
-- 		}
-- 		-- or set all headings at once
-- 		-- headings = 'subtle'
-- 	},
--
-- 	-- Change specific vm highlight groups
-- 	-- https://github.com/rose-pine/neovim/wiki/Recipes
--
-- })

-- Set colorscheme after options
-- vim.cmd('colorscheme rose-pine')

-- function ColorMyPencils(color)
-- 	color = color or "rose-pine"
-- 	vim.cmd.colorscheme(color)
-- 	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

-- ColorMyPencils()
---- require("transparent").setup({
--   groups = { -- table: default groups
-- -- 'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
-- --     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
-- --     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
-- --     'SignColumn', 'CursorLineNr', 'EndOfBuffer',
--   },
--   extra_groups = {
--   }, -- table: additional groups that should be cleared
--   exclude_groups = {}, -- table: groups you don't want to clear
-- })
