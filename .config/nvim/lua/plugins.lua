return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'scrooloose/nerdcommenter'
    use { 'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup {
                default = true;
            }
        end
    }
    use { 'rebelot/heirline.nvim',
        requires = {
            'nvim-lua/lsp-status.nvim',
        }
    }
    use { 'kylechui/nvim-surround',
        tag = "*",
        config = function()
            require'nvim-surround'.setup({})
        end
    }
    use 'vimwiki/vimwiki'
    use { 'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}}
    }
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require'gitsigns'.setup()
        end
    }
    use { 'windwp/nvim-autopairs',
        config = function()
            require'nvim-autopairs'.setup{}
            require'nvim-autopairs.completion.cmp'
        end
    }
    -- languages
    use { 'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "javascript", "python", "bash", "json", "lua", "cpp", "vim", "regex", "markdown", "markdown_inline" },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            }
        end
    }
    use { 'lervag/vimtex', -- LaTeX
        config = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_compiler_progname = 'nvr'
        end
    }
    use 'rktjmp/lush.nvim' -- for color schemes
    use { 'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use { 'ggandor/leap.nvim',
        config = function()
            local function leap_all_windows()
                local focusable_windows_on_tabpage = vim.tbl_filter(
                    function (win) return vim.api.nvim_win_get_config(win).focusable end,
                    vim.api.nvim_tabpage_list_wins(0)
                )
                require'leap'.leap { target_windows = focusable_windows_on_tabpage }
            end
            vim.keymap.set('n', 's', leap_all_windows, { silent = true })
        end
    }

    use { 'folke/which-key.nvim',
        config = function()
            local wk = require'which-key'

            local leader_mappings = {
                f = {
                    name = 'Find...',
                    f = 'Find File',
                    s = 'Find Symbols'
                },
                l = {
                    name = 'VimTex',
                    m = "Open Context Menu",
                    u = "Count Letters",
                    w = "Count Words",
                    d = "Open Doc for package",
                    e = "Look at the errors",
                    s = "Look at the status",
                    a = "Toggle Main",
                    v = "View pdf",
                    i = "Vimtex Info",
                    l = "Compile",
                    c = {
                        name = "Compile",
                        c = "Compile Project",
                        o = "Compile Project and Show Output",
                        s = "Compile project super fast",
                        e = "Compile Selected",
                    },
                    r = {
                        name = "Reload",
                        r = "Reload",
                        s = "Reload State",
                    },
                    o = {
                        name = "Stop",
                        p = "Stop",
                        a = "Stop All",
                    },
                    t = {
                        name = "TOC",
                        o = "Open TOC",
                        t = "Toggle TOC",
                    },
                },
            }

            local normal_mappings =  {
                [']'] = {
                    [']'] = 'next [sub*]section',
                    m = 'next environment',
                    n = 'next math zone',
                    r = 'next frame'

                },
                ['['] = {
                    ['['] = 'prev [sub*]section',
                    m = 'prev environment',
                    n = 'prev math zone',
                    r = 'prev frame'

                }
            }

            wk.register(leader_mappings, { prefix = '<leader>' })
            wk.register(normal_mappings)
            wk.setup{
                ignore_missing = false
            }
        end
    }
    use { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require'lsp_lines'.setup()
        end
    }
    use 'lewis6991/impatient.nvim'
    use {
        'folke/noice.nvim',
        config = function()
            require'noice'.setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    progress = {
                        enabled = false,
                    },
                },
                -- show @recording messages
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                },
                cmdline = {
                    format = {
                        cmdline = { pattern = "^:", icon = ":", lang = "vim" },
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex"},
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex"},
                        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
                        help = { pattern = "^:%s*he?l?p?%s+", icon = "", lang = "bash" },
                        search_replace = { icon = "", kind = "search", title = " Search and Replace ", pattern = "^:%s*%%s/", lang = "regex", conceal = false },
                    },
                },
                messages = {
                    view_search = false
                }

        })
        end,
        requires = {
            'MunifTanjim/nui.nvim'
        }
    }
    use { 'rcarriga/nvim-notify', -- also used for noice.nvim, but not necessary
        config = function()
            require'notify'.setup({
                fps = 60,
                icons = {
                    DEBUG = " ",
                    ERROR = " ",
                    INFO = " ",
                    TRACE = "✎ ",
                    WARN = " "
                },
                level = 2,
                minimum_width = 50,
                render = "default",
                stages = "fade",
                timeout = 5000,
                top_down = true

            })
            vim.notify = require'notify'
        end
    }
    use { 'martineausimon/nvim-lilypond-suite',
        requires = { 'MunifTanjim/nui.nvim' }
    }
end)
