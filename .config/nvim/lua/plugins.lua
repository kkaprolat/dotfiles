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
                requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use 'lewis6991/gitsigns.nvim'
        -- languages
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-compe' -- generic autocomplete
        use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate'
        }
        use 'lervag/vimtex' -- LaTeX
end)
