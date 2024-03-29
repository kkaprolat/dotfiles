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
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
        local wk = require'which-key'
        local leader_mappings = {
            f = {
                name = 'Find...',
                f = 'Find File',
                s = 'Find Symbols',
                r = 'Live Grep (ripgrep)'
            },
            c = {
                name = 'Comment...',
                ['$'] = 'to EOL',
                ['<space>'] = 'toggle',
                A = 'append',
                a = 'alt delims???',
                b = 'align both',
                c = 'comment',
                i = 'invert',
                l = 'align left',
                m = 'minimal',
                n = 'nested',
                s = 'sexy',
                u = 'uncomment',
                y = 'yank',
            },
            l = {
                name = 'VimTex...',
                a = "Open Context Menu",
                c = "Clean",
                C = "Fulll Clean",
                e = "Look at the errors",
                g = "Show status",
                G = "Show full status",
                i = "Show info",
                I = "Show full info",
                k = "Stop.",
                K = "Stop all.",
                l = "Compile",
                L = "Compile all",
                m = "imaps list",
                o = "Compile output",
                q = "Show log",
                s = "Toggle main",
                t = "Open TOC",
                T = "Toggle TOC",
                v = "View",
                x = "reload",
                X = "reload state",
            },
        }
        local normal_mappings = {
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
            ignore_missing = false,
            icons = {
                group = "",
            }
        }
    end
},
{
    'folke/noice.nvim',
    config = true,
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
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
    },
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify'
    },
},
{
    'rcarriga/nvim-notify', -- also used for noice.nvim
    config = function()
        require'notify'.setup{
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
        }
        vim.notify = require'notify'
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
{
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function ()
        require'lspsaga'.setup({
            symbol_in_winbar = {
                separator = "  ",
                show_file = true,
            },
            ui = {
                code_action = "",
                border = "solid",
            },
        })
        vim.keymap.set({"n", "v"}, "<leader>sa", "<cmd>Lspsaga code_action<CR>")
        vim.keymap.set("n", "<leader>sr", "<cmd>Lspsaga rename<CR>")
        vim.keymap.set("n", "<leader>sR", "<cmd>Lspsaga rename ++project<CR>")
        vim.keymap.set("n", "<leader>sk", "<cmd>Lspsaga peek_definition<CR>")
        vim.keymap.set("n", "<leader>sK", "<cmd>Lspsaga goto_definition<CR>")
        vim.keymap.set("n", "<leader>st", "<cmd>Lspsaga peek_type_definition<CR>")
        vim.keymap.set("n", "<leader>sT", "<cmd>Lspsaga goto_type_definition<CR>")
        vim.keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>")
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
    end,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-treesitter/nvim-treesitter'
    },
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
{
    'rcarriga/nvim-dap-ui',
    config = function ()
        local dapui = require'dapui'
        local dap = require'dap'
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
    end
},
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
    'folke/trouble.nvim',
    event = 'VeryLazy',  -- required for todo-comments.nvim...
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'trouble'.setup {
            auto_open = true,
            auto_close = false,
            use_diagnostic_signs = true,
            mode = 'workspace_diagnostics',
            padding = false
        }
        vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>")
        vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>")
        vim.keymap.set("n", "<leader>tr", "<cmd>TroubleRefresh<CR>")
    end,
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
