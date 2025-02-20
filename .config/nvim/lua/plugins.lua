return {
    'scrooloose/nerdcommenter',
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup {
                default = true;
            }
        end
    },
    {
        'rebelot/heirline.nvim',
        dependencies = {
            'nvim-lua/lsp-status.nvim',
            'rktjmp/lush.nvim', -- color schemes
        },
    },
    {
        'kylechui/nvim-surround',
        event = "VeryLazy",
        version = '*',
        config = function()
            require'nvim-surround'.setup{}
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        build = 'make',
        config = function()
            local actions = require'telescope.actions'
            require'telescope'.setup{
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close
                        }
                    }
                }
            }
            vim.keymap.set('n', '<leader>ff', function() require'telescope.builtin'.find_files() end)
            vim.keymap.set('n', '<leader>fs', function() require('telescope.builtin').lsp_document_symbols() end)
            vim.keymap.set('n', '<leader>fr', function() require('telescope.builtin').live_grep() end)
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        tag = 'release',
        config = function ()
            require'gitsigns'.setup()
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "VeryLazy",
        config = function()
            require'nvim-autopairs'.setup{}
            local cmp_autopairs = require'nvim-autopairs.completion.cmp'
            local cmp = require'cmp'
            cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
            )
        end
    },
    -- LSP
    -- LSP Support
    'neovim/nvim-lspconfig',
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require'cmp'
            local luasnip = require'luasnip'

            local has_words_before = function()
                -- we use current lua, so unpack() is available
                -- unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                },
                {
                    { name = 'luasnip' }
                },
                {
                    {
                        name = 'buffer',
                        option = {
                            keyword_pattern = [[\k\+]]
                        },
                    }
                },
                {
                    { name = 'path' }
                }
                ),
                matching = {
                    disallow_partial_fuzzy_matching = false,
                },
                mapping = cmp.mapping.preset.insert{
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm{ select = false },
                    -- Super-Tab like mappings from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" })
                },
                formatting = {
                    format = function (entry, vim_item)
                        if vim.tbl_contains({ 'path' }, entry.source.name) then
                            local icon, hl_group = require'nvim-web-devicons'.get_icon(entry:get_completion_item().label)
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end
                        return require'lspkind'.cmp_format{
                            mode = 'symbol_text',
                            preset = 'codicons',
                            menu = ({
                                buffer = "[Buffer]",
                                nvim_lsp = "[LSP]",
                                luasnip = "[LuaSnip]",
                                nvim_lua = "[Lua]",
                                latex_symbols = "[LaTeX]",
                            })
                        }(entry, vim_item)
                    end
                }
            }
    end,
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'onsails/lspkind.nvim',
        'nvim-tree/nvim-web-devicons',
        'saadparwaiz1/cmp_luasnip',
    }
},
-- Snippets
{
    'L3MON4D3/LuaSnip',
    dependencies = {
        'rafamadriz/friendly-snippets',
    }
},
{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    dependencies = {
        'nvim-treesitter/playground'
    },
    opts = {
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'javascript',
            'json',
            'latex',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'regex',
            'vim',
            'yuck',
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    }
},
{
    'lervag/vimtex', -- LaTeX
    ft = {"tex", "bib"},
    config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_progname = 'nvr'
        vim.g.vimtex_view_use_temp_files = 1
        vim.g.vimtex_compiler_latexmk = {
            options = {
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-shell-escape",
                "-pdf",
                "-pdflatex",
            }
        }
    end
},
{
    'rktjmp/lush.nvim', -- color schemes
    lazy = false, -- load it during startup
    priority = 1000, -- load before other start plugins
    config = function()
        require'lush'(require'lush_theme.my_theme')
    end
},
{
    'ggandor/leap.nvim',
    event = "VeryLazy",
    config = function()
        local function leap_current_window()
            require'leap'.leap { target_windows = { vim.fn.win_getid() } }
        end
        vim.keymap.set('n', 's', leap_current_window, { silent = true })
    end
},
{
    'martineausimon/nvim-lilypond-suite',
    ft = "lilypond",
    dependencies = {
        'MunifTanjim/nui.nvim'
    }
},
{
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
    },
    config = function ()
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99 -- ufo provider needs a large value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        vim.keymap.set('n', 'zR', require'ufo'.openAllFolds)
        vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds)
        -- nvim lsp as LSP client
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    end
},
'preservim/vim-markdown',
'elkowar/yuck.vim',
{
    'lukas-reineke/indent-blankline.nvim',
    config = true,
    main = 'ibl',
    opts = {
        scope = {
            enabled = true
        },
        --show_first_indent_level = false
    }
},
{
    'stevearc/overseer.nvim',
    config = function ()
        require'overseer'.setup({
        })
        require'overseer'.add_template_hook({}, function (task_defn, util)
            util.add_component(task_defn, { "on_output_quickfix", open = true})
        end)
        vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<CR>")
        vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<CR>")
    end,
    dependencies = {
        'stevearc/dressing.nvim'
    }
},
{
    'mfussenegger/nvim-dap',
    config = function ()
        vim.keymap.set("n", "<leader>dc", function() require'dap'.continue() end)
        vim.keymap.set("n", "<leader>do", function() require'dap'.step_over() end)
        vim.keymap.set("n", "<leader>di", function() require'dap'.step_into() end)
        vim.keymap.set("n", "<leader>dO", function() require'dap'.step_out() end)
        vim.keymap.set("n", "<leader>db", function() require'dap'.toggle_breakpoint() end)
        vim.keymap.set("n", "<leader>dB", function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    end
},
-- {
--    'rcarriga/nvim-dap-ui',
--     config = function ()
--         local dapui = require'dapui'
--         local dap = require'dap'
--         dapui.setup()
--         dap.listeners.after.event_initialized["dapui_config"] = function()
--             dapui.open()
--         end
--     end
-- },
{
    'mfussenegger/nvim-dap-python',
    config = function ()
        require'dap-python'.setup('/usr/bin/python3')
    end

},
{
    'b0o/incline.nvim',
    config = true,
    opts = {
        window = {
            margin = {
                horizontal = 0,
                vertical = 0
            },
            placement = {
                vertical = 'top'
            }
        },
        ignore = {
            buftypes = {},
            wintypes = {},
            unlisted_buffers = false,
        }
    }
},
{
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
        require'todo-comments'.setup {
            signs = false,
            keywords = {
                FIX = { icon = 'x ', color = 'fix', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }},
                TODO = { icon = 'y ', color = 'todo' },
                HACK = { icon = 'z ', color = 'hack' },
                WARN = { icon = 'a ', color = 'warn', alt = { 'WARNING', 'XXX' }},
                PERF = { icon = 'b ', color = 'perf', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' }},
                NOTE = { icon = 'c ', color = 'note', alt = { 'INFO' }},
                TEST = { icon = 'd ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' }},
            },
            gui_style = {
                fg = 'italic'
            },
            merge_keywords = true,
            highlight = {
                multiline = true,
                multiline_pattern = '^.',
                multiline_context = 10,
                before = '',
                keyword = 'wide',
                after = 'fg',
                pattern = [[<(KEYWORDS)\s*]],
                comments_only = true,
                max_line_len = 400,
                exclude = {},
            },
            colors = {
                fix = { "TodoCommentFix" },
                todo = { "TodoCommentTodo" },
                hack = { "TodoCommentHack"},
                warn = { "TodoCommentWarn" },
                perf = { "TodoCommentPerf" },
                note = { "TodoCommentNote" },
                test = { "TodoCommentTest" },
            }
        }
        vim.keymap.set("n", "<leader>tt", "<cmd>TodoTrouble<CR>")
    end,
},
{
    'dstein64/nvim-scrollview',
    config = function ()
        require'scrollview'.setup {
        excluded_filetypes = {'nerdtree'},
        current_only = true,
        base = 'right',
        signs_on_startup = {
            'conflicts',
            'diagnostics',
            'folds',
            'marks',
            'search',
        },
        hide_on_interact = true,
        folds_symbol = "",
        search_symbol = {'-', '=', '≡'},
        hover = true,
        winblend = 100,
    }
    require 'scrollview.contrib.gitsigns'.setup{
        enabled = true,
        hide_full_add = true,
        winblend_gui = 0,
        signs_max_per_row = 1,
        signs_column = 0,
    }
end
}
}
