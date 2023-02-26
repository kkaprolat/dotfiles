-- LSP

-- lsp diagnostics in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- expand diagnostics only on current line
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

local lsp_status = require'lsp-status'
lsp_status.config {
    diagnostics = false,
    status_symbol = ''
}
lsp_status.register_progress()

vim.diagnostic.config{
    signs = true,
    underline = true,
    update_in_insert = true
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspc = require'lspconfig'

-- for folding
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
require'ufo'.setup()

local servers = { 'html', 'pyright', 'bashls', 'ansiblels', 'dockerls', 'yamlls', 'rust_analyzer' }

-- basic settings for all servers
for _, lsp in ipairs(servers) do
    lspc[lsp].setup {
        capabilities = capabilities,
    }
end

-- language specific stuff
lspc.texlab.setup {
    capabilities = capabilities,
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
}

lspc.ccls.setup {
    capabilities = capabilities,
    init_options = {
        --                compilationDatabaseDirectory = 'build',
        index = {
            threads = 0
        },
        filetypes = { 'c', 'cpp' }
    },

}

lspc.lua_ls.setup {
    capabilities = capabilities,
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
                -- stop asking for luassert
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            },
        },
    },

}

-- lsp.setup_nvim_cmp({
--         sources = {
--                 name = 'buffer',
--                 option = {
--                         keyword_pattern = [[\k\+]]
--                 }
--         }
-- })




-- LSP notifications via rcarriga/nvim-notify
-- from https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes

local client_notifs = {}

local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then
        client_notifs[client_id] = {}
    end

    if not client_notifs[client_id][token] then
        client_notifs[client_id][token] = {}
    end

    return client_notifs[client_id][token]
end

local spinner_frames = { "", "", "", "", "", "" } -- this requires Fira Code!

local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification,
        })

        vim.defer_fn(function()
            update_spinner(client_id, token)
        end, 100)
    end
end

local function format_title(title, client_name)
    return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
    return (percentage and percentage .. "%\t" or "") .. (message or "")
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then
        return
    end

    local notif_data = get_notif_data(client_id, result.token)

    if val.kind == 'begin' then
        local message = format_message(val.message, val.percentage)

        notif_data.notification = vim.notify(message, 'info', {
            title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
            icon = spinner_frames[1],
            timeout = false,
            hide_from_history = false,
        })

        notif_data.spinner = 1
        update_spinner(client_id, result.token)
    elseif val.kind == 'report' and notif_data then
        notif_data.notification = vim.notify(format_message(val.message, val.percentage), 'info', {
            replace = notif_data.notification,
            hide_from_history = false,
        })
    elseif val.kind == 'end' and notif_data then
        notif_data.notification = vim.notify(val.message and format_message(val.message) or 'Complete', 'info', {
            icon = '',
            replace = notif_data.notification,
            timeout = 3000,
        })

        notif_data.spinner = nil
    end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

