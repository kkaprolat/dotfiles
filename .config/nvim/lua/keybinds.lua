local g = vim.g
local map = vim.api.nvim_set_keymap
local nr = { noremap = true }

-- Keymaps
-- map(mode, key sequence, command, options)
-- Leader on space
g.mapleader = ' '
g.maplocalleader = ' '

-- Telescope
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files()<cr>", nr)
map('n', '<leader>fs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", nr)

-- nvim-compe
map('i', '<silent><expr> <C-Space>', 'compe#complete()', nr)
map('i', '<silent><expr> <CR>', 'compe#confirm("<CR>")', nr)
map('i', '<silent><expr> <C-e>', 'compe#close("<C-e>")', nr)
map('i', '<silent><expr> <C-f>', 'compe#scroll({ "delta": +4 })', nr)
map('i', '<silent><expr> <C-d>', 'compe#scroll({ "delta": -4 })', nr)

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
