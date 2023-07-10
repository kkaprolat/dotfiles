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
-- o.lazyredraw = true

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

-- for nvim-cmp
o.completeopt = 'menuone,noselect'

o.timeoutlen = 500

-- hide command line unless used
o.cmdheight = 0

-- don't notify when mode changes
o.showmode = false

-- see https://www.reddit.com/r/neovim/comments/1052d98/comment/j39bgco/?utm_source=share&utm_medium=web2x&context=3
-- and https://github.com/creativenull/dotfiles/blob/9ae60de4f926436d5682406a5b801a3768bbc765/config/nvim/init.lua#L70-L86
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lastplace,
    pattern = { "*" },
    desc = "remember last cursor place",
    callback = function(args)
        local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
        local not_commit = vim.b[args.buf].filetype ~= 'commit'

        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if valid_line and not_commit then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
