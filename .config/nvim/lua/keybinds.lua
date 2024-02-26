local g = vim.g
local map = vim.api.nvim_set_keymap
local nr = { noremap = true }

-- Keymaps
-- map(mode, key sequence, command, options)
-- Leader on space
g.mapleader = ' '
g.maplocalleader = ' '

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

-- move lines and fix indentation
map('n', '<A-j>', '<cmd>m .+1<cr>==', nr)
map('n', '<A-k>', '<cmd>m .-2<cr>==', nr)

-- easier window movement
map('n', '<C-h>', '<C-w>h', nr)
map('n', '<C-j>', '<C-w>j', nr)
map('n', '<C-k>', '<C-w>k', nr)
map('n', '<C-l>', '<C-w>l', nr)

-- disable F1
map('n', '<F1>', '<nop>', nr)
