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

-- enable mouse support
o.mouse = 'a'

-- keep line in center
o.scrolloff = 9999

-- concealment for LaTeX
o.conceallevel = 2

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
map('n', '<leader>fs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", nr)

-- nvim-compe
map('i', '<silent><expr> <C-Space>', 'compe#complete()', nr)
map('i', '<silent><expr> <CR>', 'compe#confirm("<CR>")', nr)
map('i', '<silent><expr> <C-e>', 'compe#close("<C-e>")', nr)
map('i', '<silent><expr> <C-f>', 'compe#scroll({ "delta": +4 })', nr)
map('i', '<silent><expr> <C-d>', 'compe#scroll({ "delta": -4 })', nr)

-- lightspeed.nvim
map('n', 's', '<Plug>Lightspeed_omni_s', {})

-- lsp diagnostics in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- automatic formatting
vim.cmd [[autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting()]]


local cmp = require'cmp'
cmp.setup({
        snippet = {
                expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                end
        },
        mapping = {
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's' }),
        },

        sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'calc' },
                { name = 'path' },
                { name = 'buffer',
                  option = {
                        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]],
                        },
                },

        },
        formatting = {
                format = function(entry, vim_item)
                        vim_item.menu = ({
                                luasnip = '[SNP]',
                                nvim_lsp = '[LSP]',
                                calc = '[CLC]',
                                path = '[PTH]',
                                buffer = '[BUF]',
                        })[entry.source.name]
                        vim_item.kind = ({
                                Text =          '', -- Text
                                Method =        '', -- Method
                                Function =      '', -- Function
                                Constructor =   '', -- Constructor
                                Field =         'ﰠ', -- Field
                                Variable =      '', -- Variable
                                Class =         'ﴯ', -- Class
                                Interface =     'ﰮ', -- Interface
                                Module =        '', -- Module
                                Property =      '', -- Property
                                Unit =          '塞', -- Unit
                                Value =         '', -- Value
                                Enum =          '', -- Enum
                                Keyword =       '', -- Keyword
                                Snippet =       '', -- Snippet
                                Color =         '', -- Color
                                File =          '', -- File
                                Reference =     '', -- Reference
                                Folder =        '', -- Folder
                                EnumMember =    '', -- EnumMember
                                Constant =      '', -- Constant
                                Struct =        '', -- Struct
                                Event =         '', -- Event
                                Operator =      '', -- Operator
                                TypeParamter =  '', -- TypeParameter
                        })[vim_item.kind]
                        return vim_item
                end
        }
})

require'nvim-autopairs'.setup{}
local cmp_autopairs = require'nvim-autopairs.completion.cmp'
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- languages
local lspconfig = require'lspconfig'
lspconfig.pyright.setup{
        capabilities = capabilities,
        on_attach = on_attach,

}
lspconfig.texlab.setup{
        cmd = { 'texlab' },
        filetypes = { 'tex', 'bib' },
        settings = {
                latex = {
                        lint = {
                                onChange = true,
                                onSave = true
                        }
                }
        },
        texlab = {
                latexFormatter = 'latexindent',
        },
        capabilities = capabilities,
        on_attach = on_attach,
}
lspconfig.ccls.setup {
        init_options = {
                compilationDatabaseDirectory = 'build';
                index = {
                        threads = 0;
                };
        },
        capabilities = capabilities,
        on_attach = on_attach,
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
})


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
        ensure_installed = { "c", "javascript", "python", "bash", "json", "lua", "cpp" },
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


-- colorscheme
o.background = 'dark'
-- g.colors_name = 'my_theme'
require'lush'(require'lush_theme.my_theme')
-- cmd("colorscheme my_theme")

-- feline
require'feline'.setup(require'my_feline')

-- lightspeed
require'lightspeed'.setup {
        exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
        limit_ft_matches = 16,

}
