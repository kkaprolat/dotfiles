-- LSP

-- lsp diagnostics in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- expand diagnostics only on current line
vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

local lsp_status = require'lsp-status'
lsp_status.config {
        diagnostics = false,
        status_symbol = ''
}
lsp_status.register_progress()

local lsp = require'lsp-zero'
lsp.preset('system-lsp')
lsp.setup_servers({
        'html',
        'pyright',
        'bashls',
})

-- language specific stuff
navic = require'nvim-navic'
lsp.configure('texlab', {
        filetypes = { 'tex', 'bib' },
        settings = {
                latex = {
                        lint = {
                                onChange = true,
                                onSave = true
                        }
                }
        },
        texlab = {
                latexFormatter = 'latexindent'
        },
        on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
        end,
})

lsp.configure('ccls', {
        init_options = {
--                compilationDatabaseDirectory = 'build',
                index = {
                        threads = 0
                },
                filetypes = { 'c', 'cpp' }
        },
        on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
        end,
})
lsp.configure('sumneko_lua', {
        settings = {
                Lua = {
                        runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                        },
                        diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim' },
                        },
                        workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                                enable = false
                        },
                },
        },
        on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
        end,
})
-- lsp.setup_nvim_cmp({
--         sources = {
--                 name = 'buffer',
--                 option = {
--                         keyword_pattern = [[\k\+]]
--                 }
--         }
-- })
lsp.setup()
