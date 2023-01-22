local fn = vim.fn
local execute = vim.api.nvim_command

-- bootstrap lazy.nvim
local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require'options'
require'keybinds'
require'lazy'.setup('plugins', {
    checker = {
        enabled = true,
        concurrency = 5,
        notify = true,
        frequency = 3600,
    }
})

require'lsp'

-- heirline
require'my_heirline'
