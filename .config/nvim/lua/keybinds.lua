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

