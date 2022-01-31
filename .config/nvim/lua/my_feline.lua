local vi_mode_utils = require'feline.providers.vi_mode'
local lsp = require'feline.providers.lsp'
local vlsp = vim.lsp

-- from https://github.com/famiu/feline.nvim/blob/master/lua/feline/providers/lsp.lua

local components = {
        active = {},
        inactive = {},
}
table.insert(components.active, {}) -- left
table.insert(components.active, {}) -- mid
table.insert(components.active, {}) -- right

-- vi_mode
table.insert(components.active[1], {
        provider = 'vi_mode',
        hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'black'
                val.style = 'bold'
                return val
        end,
        right_sep = 'block',
        left_sep =  'block',
        icon = ''
})

-- file info
table.insert(components.active[1], {
        provider = 'file_info',
        hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'black'
                return val
        end,
        type = 'relative',
        colored_icon = false,
        right_sep = 'block',
})

-- file size
table.insert(components.active[1], {
        provider = 'file_size',
        hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'black'
                return val
        end,
        type = 'relative',
        left_sep = 'block',
        right_sep = function()
                local val = { hl = { fg = vi_mode_utils.get_mode_color() } }
                if (false) then
                        val.str = 'block'
                else
                        val.str = 'right_rounded'
                end
                return val
        end,
})

-- git branch
table.insert(components.active[1], {
        provider = 'git_branch',
        left_sep = ' ',
})

-- git changes
table.insert(components.active[1], {
        provider = 'git_diff_added',
        icon = '+',
        hl = function()
                local val = {}
                val.bg = 'bg1'
                val.fg = 'green'
                return val
        end,
        left_sep = ' '
})
table.insert(components.active[1], {
        provider = 'git_diff_changed',
        icon = '~',
        hl = function()
                local val = {}
                val.bg = 'bg1'
                val.fg = 'yellow'
                return val
        end,
        left_sep = ' '
})
table.insert(components.active[1], {
        provider = 'git_diff_removed',
        icon = '-',
        hl = function()
                local val = {}
                val.bg = 'bg1'
                val.fg = 'red'
                return val
        end,
        left_sep = ' '
})

-- diagnostics
table.insert(components.active[3], {
        provider = 'diagnostic_errors',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
        hl = function()
                local val = {}
                val.bg = 'red'
                val.fg = 'black'
                return val
        end,
        left_sep = 'left_rounded',
        right_sep = 'block',
})
table.insert(components.active[3], {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
        hl = function()
                local val = {}
                val.bg = 'orange'
                val.fg = 'black'
                return val
        end,
        right_sep = 'block',
        left_sep = function()
                local val = { hl = { fg = 'orange', bg = 'black' } }
                if (lsp.diagnostics_exist('Error')) then
                        val.str = 'block'
                else
                        val.str = 'left_rounded'
                end
                return val
        end,
})
table.insert(components.active[3], {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
        hl = function()
                local val = {}
                val.bg = 'blue'
                val.fg = 'black'
                return val
        end,
        right_sep = 'block',
        left_sep = function()
                local val = { hl = { fg = 'blue', bg = 'black' } }
                if (lsp.diagnostics_exist(vim.diagnostic.severity.WARN) or lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)) then
                        val.str = 'block'
                else
                        val.str = 'left_rounded'
                end
                return val
        end,
})
table.insert(components.active[3], {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
        hl = function()
                local val = {}
                val.bg = 'white'
                val.fg = 'black'
                return val
        end,
        right_sep = 'block',
        left_sep = function()
                local val = { hl = { fg = 'blue', bg = 'black' } }
                if (lsp.diagnostics_exist(vim.diagnostic.severity.HINT) or lsp.diagnostics_exist(vim.diagnostic.severity.WARN) or lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)) then
                        val.str = 'block'
                else
                        val.str = 'left_rounded'
                end
                return val
        end,
})

-- file type
table.insert(components.active[3], {
        provider = 'file_encoding',
        hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'black'
                return val
        end,
        right_sep = 'block',
        left_sep = function()
                local val = { hl = { fg = vi_mode_utils.get_mode_color() } }
                if (lsp.diagnostics_exist(vim.diagnostic.severity.INFO) or lsp.diagnostics_exist(vim.diagnostic.severity.HINT) or lsp.diagnostics_exist(vim.diagnostic.severity.WARN) or lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)) then
                        val.str = 'block'
                else
                        val.str = 'left_rounded'
                end
                return val
        end,
})

-- position
table.insert(components.active[3], {
        provider = 'position',
        hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'black'
                val.style = 'bold'
                return val
        end,
        right_sep = 'block',
        left_sep = 'block',
})

-- line_percentage
table.insert(components.active[3], {
        provider = 'line_percentage',
        hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'black'
                val.style = 'bold'
                return val
        end,
        right_sep = 'block',
        left_sep = 'block',
})

return {
        theme = require'colors',
        components = components,
        vi_mode_colors = { 
                NORMAL = 'green',
                OP = 'green',
                INSERT = 'blue',
                VISUAL = 'orange',
                BLOCK = 'orange',
                REPLACE = 'purple',
                ['V-REPLACE'] = 'purple',
                ENTER = 'yellow',
                MORE = 'yellow',
                SELECT = 'red',
                COMMAND = 'green',
                SHELL = 'green',
                TERM = 'green',
                NONE = '#ffffff',
        },
        force_inactive = {
                filetypes = {},
                buftypes = {},
                bufnames = {}
        }
}
