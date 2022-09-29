local fn = vim.fn
local execute = vim.api.nvim_command

-- bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
        execute 'packadd packer.nvim'
end

require'impatient'

require'plugins'
require'options'
require'lsp'
require'keybinds'

require'lush'(require'lush_theme.my_theme')

-- heirline
require'my_heirline'
