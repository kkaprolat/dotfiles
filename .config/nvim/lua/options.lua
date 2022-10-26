local o = vim.o

-- enable mouse support
o.mouse = 'a'

-- keep signcolumn enabled so the numbers don't shift around
o.signcolumn = 'yes'

-- keep line in center
o.scrolloff = 9999

-- concealment for LaTeX
o.conceallevel = 2

-- always display statusline globally
o.laststatus = 3

-- Copy/Paste on right register
o.clipboard = 'unnamedplus'

-- better word wrapping
o.linebreak = true
o.breakindent = true

-- traverse line breaks with arrow keys
o.whichwrap = 'b,s,<,>,[,]'

-- line numbers
o.number = true
o.rnu = false

-- color scheme
o.syntax = 'on'

-- Tabs
local indentsize = 4
o.tabstop = indentsize      -- visual spaces per tab
o.softtabstop = indentsize  -- number of spaces in tab when editing
o.shiftwidth = indentsize   -- for existing indentation
o.autoindent = true
o.expandtab = true          -- tabs are spaces

-- highlight current line
o.cursorline = true

-- redraw only when we need to
o.lazyredraw = true

-- highlight matching [{()}]
o.showmatch = true

-- search
o.incsearch = true   -- search as characters are entered
o.hlsearch = true     -- highlight matches

-- folding
o.foldenable = false   -- disable folding

-- truecolor
o.termguicolors = true

-- for devicons
o.encoding = 'UTF-8'

-- for nvim-compe
o.completeopt = 'menuone,noselect'

o.timeoutlen = 500

-- hide command line unless used
o.cmdheight = 0
