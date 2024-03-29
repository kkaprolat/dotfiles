local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local colors = {
    bright_bg = utils.get_highlight("Heirline"),
    red = utils.get_highlight("HeirlineRed"),
    green = utils.get_highlight("HeirlineGreen"),
    blue = utils.get_highlight("HeirlineBlue"),
    gray = utils.get_highlight("HeirlineGray"),
    orange = utils.get_highlight("HeirlineOrange"),
    purple = utils.get_highlight("HeirlinePurple"),
    cyan = utils.get_highlight("HeirlineCyan"),
    white = utils.get_highlight("HeirlineWhite"),
    yellow = utils.get_highlight("HeirlineYellow"),
    git_add = utils.get_highlight("HeirlineGitAdd"),
    git_change = utils.get_highlight("HeirlineGitChange"),
    git_remove = utils.get_highlight("HeirlineGitRemove"),
}

local function get_signs(self, group)
    local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
        group = '*',
        lnum = vim.v.lnum
    })

    if #signs == 0 or signs[1].signs == nil then
        self.sign = nil
        self.has_sign = false
        return
    end

    return vim.tbl_filter(function(sign) return vim.startswith(sign.group, group) end, signs[1].signs)
end

require 'heirline'.load_colors(colors)

local function get_highlight_table(color)
    local col = utils.get_highlight('Heirline'..color)
    return {
        fg = col.fg,
        bg = col.bg
    }
end

-- basic building blocks
local Align = { provider = "%=" }
local Space = { provider = " " }
local RightCapColored = {
    provider = "",
    hl = function(self)
        return { fg = self:mode_color().bg, bg = 'NONE', bold = true }
    end,
}
local function RightCapStatic(color)
    return {
        provider = "",
        hl = { fg = color.bg, bg = 'NONE', bold = true }
    }
end
local LeftCapColored = {
    provider = "",
    hl = function(self)
        return { fg = self:mode_color().bg, bg = 'NONE', bold = true }
    end,
}
local function LeftCapStatic(color)
    return {
        provider = "",
        hl = { fg = color.bg, bg = 'NONE', bold = true }
    }
end

local function SpaceStatic(color)
    return {
        provider = " ",
        hl = { fg = color.fg, bg = 'NONE', bold = true }
    }
end
local ColoredSpace = {
    provider = " ",
    hl = function(self)
        return { bg = self:mode_color().bg }
    end
}

-- left

local FileFlags = {
    provider = function ()
        if vim.bo.modified then
            return ""
        end
        if (not vim.bo.modifiable) or vim.bo.readonly then
            return ""
        end
        return " "
    end
}

local ViMode = { RightCapColored,
FileFlags,
{
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string. We can put these into `static` to compute
    -- them at initialization time.
    static = {
        mode_names = { -- change the strings if you like it verbose
        n = "",
        no = "NORMAL-OPERATOR?",
        nov = "NORMAL-OPERATOR?",
        noV = "NORMAL-OPERATOR?",
        ["no\22"] = "NORMAL-OPERATOR?",
        niI = "NORMAL (INSERT)",
        niR = "NORMAL (REPLACE)",
        niV = "NORMAL (VIRT-REPLACE)",
        nt = "NORMAL (TERM)",
        v = "VISUAL",
        vs = "Vs",
        V = "VISUAL (LINE)",
        Vs = "VISUAL (LINE)",
        ["\22"] = "VISUAL (BLOCK)",
        ["\22s"] = "VISUAL (BLOCK)",
        s = "SELECT",
        S = "SELECT (LINE)",
        ["\19"] = "SELECT (BLOCK)",
        i = "INSERT",
        ic = "INSERT (COMPL)",
        ix = "INSERT (X-COMPL)",
        R = "REPLACE",
        Rc = "REPLACE (COMPL)",
        Rx = "REPLACE (X-COMPL)",
        Rv = "REPLACE (VIRTUAL)",
        Rvc = "REPLACE (VIRTUAL-COMPL)",
        Rvx = "REPLACE (VIRTUAL-X-COMPL)",
        c = "COMMAND",
        cv = "EX",
        r = "...",
        rm = "+++",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
    },
},
-- We can now access the value of mode() that, by now, would have been
-- computed by `init()` and use it to index our strings dictionary.
-- note how `static` fields become just regular attributes once the
-- component is instantiated.
-- To be extra meticulous, we can also add some vim statusline syntax to
-- control the padding and make sure our string is always at least 2
-- characters long. Plus a nice Icon.
provider = function(self)
    return "%2( ".. self.mode_names[vim.fn.mode(1)] .. " %)"
end,
-- Re-evaluate the component only on ModeChanged event.
-- This is not required in any way, but it's there, and it's a small
-- performance improvement.
-- does not work with Noice
-- update = 'ModeChanged'
},
-- Same goes for the highlight. Now the background will change according to the current mode.
hl = function(self)
    local color = self:mode_color()
    return { bg = color.bg, fg = color.fg, bold = true, }
end,
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and its children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = "HeirlineWhite"
}

-- We can now define some children separately and add them later
local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require 'nvim-web-devicons'.get_icon_color(filename, extension,
            { default = true })
    end,
    provider = function(self)
        return self.icon and ('' .. self.icon .. ' ')
    end,
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifiers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below (in cookbok.md) for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
}

local FileSize = {
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'B', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize..' '..suffix[1]..' '
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g %siB ", fsize / math.pow(1024, i), suffix[i + 1])
    end,
}

local Spacer = {
    provider = " | "
}


-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
    FileNameBlock,
    Spacer,
    FileIcon,
    FileName,
    Spacer,
    FileSize,
    LeftCapStatic(colors.white),
    { provider = '%<' }-- this means that the statusline is cut here when there's not enough space
)

-- right
local ScrollBar = {
    RightCapStatic(colors.orange),
    {
        provider = " %P | %l:%c ",
        hl = colors.orange
    },
    LeftCapStatic(colors.orange),
}

local LspMessages = {
    provider = function(self)
        return require'lsp-status'.status(0)
    end,
    hl = { fg = utils.get_highlight("Heirline").fg }
}

local Diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        condition = function(self)
            return self.errors > 0
        end,

        RightCapStatic(utils.get_highlight('HeirlineError')),
        {
            provider = function(self)
                -- 0 is just another output, we can decide to print it or not!
                return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            end,
            hl = "HeirlineError"
        },
        LeftCapStatic(utils.get_highlight('HeirlineError')),
    },
    {
        condition = function(self)
            return self.warnings > 0
        end,

        RightCapStatic(utils.get_highlight('HeirlineWarn')),
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            end,
            hl = "HeirlineWarn"
        },
        LeftCapStatic(utils.get_highlight('HeirlineWarn')),
    },
    {
        condition = function(self)
            return self.info > 0
        end,

        RightCapStatic(utils.get_highlight('HeirlineInfo')),
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. " ")
            end,
            hl = "HeirlineInfo"
        },
        LeftCapStatic(utils.get_highlight('HeirlineInfo')),
    },
    {
        condition = function(self)
            return self.hints > 0
        end,

        RightCapStatic(utils.get_highlight('HeirlineHint')),
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
            end,
            hl = "HeirlineHint"
        },
        LeftCapStatic(utils.get_highlight('HeirlineHint')),
    },
}

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    -- hl = {}
    RightCapStatic(utils.get_highlight('HeirlineOrange')),
    {
        provider = " ",
        hl = 'HeirlineOrange'
    },
    {
        provider = function(self)
            return ' ' .. self.status_dict.head
        end,
        hl = { fg = colors.white.bg, bg = colors.git_change.bg }
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" +" .. count)
        end,
        hl = { fg = colors.git_add.fg, bg = colors.git_add.bg }
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" -" .. count)
        end,
        hl = { fg = colors.git_remove.fg, bg = colors.git_remove.bg }
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" ~" .. count)
        end,
        hl = { fg = colors.git_change.fg, bg = colors.git_change.bg }
    },
    LeftCapStatic({fg = 'NONE', bg = colors.git_change.bg }),
}

local Updates = {
    {
        condition = require'lazy.status'.has_updates,
        RightCapStatic(utils.get_highlight('HeirlineYellow')),
    },
    {
        condition = require'lazy.status'.has_updates,
        provider = require'lazy.status'.updates,
        hl = { fg = colors.yellow.fg, bg = colors.yellow.bg }
    },
    {
        condition = require'lazy.status'.has_updates,
        LeftCapStatic(utils.get_highlight('HeirlineYellow')),
    },
}


local SearchResults = {
    {
        condition = function()
            return vim.v.hlsearch ~= 0 and vim.fn.getreg("/") ~= ""
        end,
        RightCapStatic(colors.green),
        {
            provider = function()
                local ok, search = pcall(vim.fn.searchcount)
                if ok and search.total then
                    return ' ' .. vim.fn.getreg("/") .. ' ' .. string.format("%d/%d", search.current, math.min(search.total, search.maxcount))
                else
                    return "ERROR"
                end
            end,
            hl = colors.green
        },
        LeftCapStatic(colors.green),
    }
}

local DefaultStatusLine = {
    -- ViMode, FileNameBlock, RightCap, Space, Git, Align, Navic, LspMessages, Space, Diagnostics, Space, RightCap, SearchResults, ScrollBar
    ViMode, FileNameBlock, Space, Updates, Space, Git, Align, Diagnostics, Align, SearchResults, Space, ScrollBar
}

local StatusLines = {
    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,
    static = {
        mode_colors = {
            n = utils.get_highlight('HeirlineGreen'), --"green"),
            i = utils.get_highlight('HeirlineBlue'), -- "blue"),
            v = utils.get_highlight('HeirlineOrange'), -- "orange"),
            V = utils.get_highlight('HeirlineOrange'), -- "orange"),
            ["\22"] = utils.get_highlight('HeirlineOrange'), -- "orange",
            c = utils.get_highlight('HeirlineGreen'), -- "green",
            s = utils.get_highlight('HeirlinePurple'), -- "purple",
            S = utils.get_highlight('HeirlinePurple'), -- "purple",
            ["\19"] = utils.get_highlight('HeirlinePurple'), -- "purple",
            R = utils.get_highlight('HeirlinePurple'), -- "purple",
            r = utils.get_highlight('HeirlinePurple'), -- "purple",
            ["!"] = utils.get_highlight('HeirlineRed'), -- "red",
            t = utils.get_highlight('HeirlineRed'), -- "red",
        },
        mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or "n"
            return self.mode_colors[mode]
        end,
    },
    fallthrough = false,

    DefaultStatusLine
}

local StatusColumn = {
    static = {
        -- from https://github.com/olimorris/dotfiles/commit/c2b901076ff04ecade8acc63fb7f8c98f514713e
        click_args = function (self, minwid, clicks, button, mods)
            local args = {
                minwid = minwid,
                clicks = clicks,
                button = button,
                mods = mods,
                mousepos = vim.fn.getmousepos()
            }
            local sign = vim.fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol)
            if sign == ' ' then sign = vim.fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol - 1) end
            args.sign = self.signs[sign]
            vim.api.nvim_set_current_win(args.mousepos.winid)
            vim.api.nvim_win_set_cursor(0, { args.mousepos.line, 0 })
            return args
        end,
        handlers = {
            line_number = function(args)
                local dap_avail, dap = pcall(require, 'dap')
                if dap_avail then vim.schedule(dap.toggle_breakpoint) end
            end,
            diagnostics = function(args) vim.schedule(vim.diagnostic.open_float) end,
            git_signs = function(args)
                local gitsigns_avail, gitsigns = pcall(require, 'gitsigns')
                if gitsigns_avail then vim.schedule(gitsigns.preview_hunk) end
            end,
            fold = function(args)
                local lnum = args.mousepos.line
                if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return end
                vim.cmd.execute("'" .. lnum .. "fold" .. (vim.fn.foldclosed(lnum) == -1 and 'close' or 'open') .. "'")
            end,
        }
    },
    init = function(self)
        self.signs = {}
        for _, sign in ipairs(vim.fn.sign_getdefined()) do
            if sign.text then self.signs[sign.text:gsub('%s', '')] = sign end
        end
    end,
    -- folding
    {
        provider = function()
            if vim.v.virtnum ~= 0 then return '  ' end

            local lnum = vim.v.lnum
            local icon = '  '

            if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
                if vim.fn.foldclosed(lnum) == -1 then
                    icon = ' '
                else
                    icon = ' '
                end
            end

            return icon
        end,
        on_click = {
            name = 'fold_click',
            callback = function(self, ...)
                if self.handlers.fold then self.handlers.fold(self.click_args(self, ...)) end
            end,
        },
    },
    -- line number
    {
        provider = function()
            if vim.v.virtnum > 0 then return string.rep(" ", math.floor(math.log(vim.v.lnum)+1)) end
            return '%=' .. vim.v.lnum
            -- the other code seems buggy
            --if vim.v.relnum == 0 then return vim.v.lnum end
            --return vim.v.relnum
        end,
        on_click = {
            name = 'line_number_click',
            callback = function(self, ...)
                if self.handlers.line_number then self.handlers.line_number(self.click_args(self, ...)) end
            end,
        },
    },
    -- breakpoints
    {
        init = function(self)
            local signs = get_signs(self, 'dap')

            if #signs == 0 or signs == nil then
                self.sign = nil
            else
                self.sign = signs[1]
            end

            self.has_sign = self.sign ~= nil
        end,
        provider = function(self)
            if self.has_sign then return '' end
            return ' '
        end,
        hl = function(self)
            if self.has_sign then return 'DebugBreakpoint' end
        end,
    },
    -- Git and boundary
    {
        init = function(self)
            local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
                group = 'gitsigns_vimfn_signs_',
                id = vim.v.lnum,
                lnum = vim.v.lnum
            })

            if #signs == 0 or signs[1].signs == nil or #signs[1].signs == 0 or signs[1].signs[1].name == nil then
                self.sign = nil
            else
                self.sign = signs[1].signs[1]
            end

            self.has_sign = self.sign ~= nil
        end,
        provider = function(self)
            local signs = {
                GitSignsAdd = '🭳',
                GitSignsChange = '🭳',
                GitSignsTopDelete = 'T',
                GitSignsDelete = '▁',
                GitSignsUntracked = '',
                GitSignsChangeDelete = 'c'
            }
            if self.has_sign then
                if signs[self.sign.name] ~= nil then
                    return signs[self.sign.name]
                end
            else
                return signs.GitSignsAdd
            end
        end,
        hl = function(self)
            if self.has_sign then return self.sign.name end
        end,
        on_click = {
            name = 'gitsigns_click',
            callback = function(self, ...)
                if self.handlers.git_signs then self.handlers.git_signs(self.click_args(self, ...)) end
            end,
        }
    },
}
vim.o.laststatus = 3


require'heirline'.setup({
    statusline = StatusLines,
--    winbar = ...,
--    tabline = ...,
    statuscolumn = StatusColumn,
})
