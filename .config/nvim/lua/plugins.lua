return require('packer').startup(function(use)
        use 'wbthomason/packer.nvim'
        use 'scrooloose/nerdcommenter'
        use 'Xuyuanp/nerdtree-git-plugin'
        use 'tiagofumo/vim-nerdtree-syntax-highlight'
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
                        'SmiteshP/nvim-navic'
                }
        }
        use 'tpope/vim-surround'
        use 'vimwiki/vimwiki'
        use 'Shougo/context_filetype.vim'
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'
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
                                ensure_installed = { "c", "javascript", "python", "bash", "json", "lua", "cpp" },
                                highlight = {
                                        enable = true,
                                },
                                indent = {
                                        enable = true,
                                },
                        }
                end
        }
        use 'lervag/vimtex' -- LaTeX
        use 'rktjmp/lush.nvim' -- for color schemes
        use { 'romgrk/barbar.nvim',
                requires = {'kyazdani42/nvim-web-devicons'}
        }
        use 'ggandor/leap.nvim'
end)
