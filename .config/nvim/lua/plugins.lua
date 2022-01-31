return require('packer').startup(function()
        use 'wbthomason/packer.nvim'
        use 'scrooloose/nerdcommenter'
        use 'Xuyuanp/nerdtree-git-plugin'
        use 'tiagofumo/vim-nerdtree-syntax-highlight'
        use 'kyazdani42/nvim-web-devicons'
        use 'famiu/feline.nvim'
        use 'tpope/vim-surround'
        use 'vimwiki/vimwiki'
        use 'Shougo/context_filetype.vim'
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'
        use {
                'nvim-telescope/telescope.nvim',
                requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}}
        }
        use 'lewis6991/gitsigns.nvim'
        use 'windwp/nvim-autopairs'
        -- languages
        use 'neovim/nvim-lspconfig'
        use {
                'hrsh7th/nvim-cmp', -- generic autocomplete
                requires = {
                        'L3MON4D3/LuaSnip',
                        'hrsh7th/cmp-buffer',
                        'hrsh7th/cmp-nvim-lsp',
                        'hrsh7th/cmp-path',
                        'hrsh7th/cmp-calc',
                        'saadparwaiz1/cmp_luasnip',
                }
        }
        use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate',
        }
        use 'lervag/vimtex' -- LaTeX
        use 'rktjmp/lush.nvim' -- for color schemes
        use {
                'romgrk/barbar.nvim',
                requires = {'kyazdani42/nvim-web-devicons'}
        }
end)
