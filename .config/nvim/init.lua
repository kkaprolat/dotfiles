local fn = vim.fn
local execute = vim.api.nvim_command

-- bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
        execute 'packadd packer.nvim'
end

require'plugins'
require'options'
require'lsp'
require'keybinds'

require'lush'(require'lush_theme.my_theme')

-- heirline
require'my_heirline'

-- leap
local function leap_all_windows()
        local focusable_windows_on_tabpage = vim.tbl_filter(
                function (win) return vim.api.nvim_win_get_config(win).focusable end,
                vim.api.nvim_tabpage_list_wins(0)
        )
        require'leap'.leap { target_windows = focusable_windows_on_tabpage }
end

vim.keymap.set('n', 's', leap_all_windows, { silent = true })
