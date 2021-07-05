local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.o
local map = vim.api.nvim_set_keymap
local nr = { noremap = true }

local execute = vim.api.nvim_command

-- bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
        execute 'packadd packer.nvim'
end

require('plugins')

-- always display statusline
o.laststatus = 2 

-- Copy/Paste on right register
o.clipboard = 'unnamedplus'

-- better word wrapping
o.linebreak = true
o.breakindent = true

-- traverse line breaks with arrow keys
o.whichwrap = 'b,s,<,>,[,]'

-- line numbers
o.number = true
o.rnu = true

-- color scheme
o.syntax = 'on'

-- Tabs
o.tabstop = 4         -- visual spaces per tab
o.softtabstop = 4     -- number of spaces in tab when editing
o.expandtab = true    -- tabs are spaces

-- highlight current line
o.cursorline = true

-- redraw only when we need to
o.lazyredraw = true

-- highlight matching [{()}]
o.showmatch = true

-- search
o. incsearch = true   -- search as characters are entered
o.hlsearch = true     -- highlight matches

-- folding
o.foldenable = false   -- disable folding

-- truecolor
o.termguicolors = true

-- for devicons
o.encoding = 'UTF-8'

-- for nvim-compe
o.completeopt = 'menuone,noselect'

-- Keymaps
-- map(mode, key sequence, command, options)
-- Leader on space
map('n', '<Space>', '', {})
g.mapleader = ' '
g.maplocalleader = ' '

-- Telescope
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", nr)

-- nvim-compe
map('i', '<silent><expr> <C-Space>', 'compe#complete()', nr)
map('i', '<silent><expr> <CR>', 'compe#confirm("<CR>")', nr)
map('i', '<silent><expr> <C-e>', 'compe#close("<C-e>")', nr)
map('i', '<silent><expr> <C-f>', 'compe#scroll({ "delta": +4 })', nr)
map('i', '<silent><expr> <C-d>', 'compe#scroll({ "delta": -4 })', nr)


-- languages
local lspconfig = require'lspconfig'
lspconfig.pyright.setup{}
lspconfig.texlab.setup{}
lspconfig.ccls.setup {
        init_options = {
                compilationDatabaseDirectory = 'build';
                index = {
                        threads = 0;
                };
        }
}
require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = true;

        source = {
                path = true;
                buffer = true;
                calc = true;
                nvim_lua = true;
                nvim_lsp = true;
        };
}

local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                return true
        else
                return false
        end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "javascript", "python", "bash", "json", "lua" },
        highlight = {
                enable = true,
                },
        indent = {
                enable = true,
                },
}

-- gitsigns
require'gitsigns'.setup()

-- nvim-web-devicons
require'nvim-web-devicons'.setup {
        default = true;
}

-- feline
require'feline'.setup({})
