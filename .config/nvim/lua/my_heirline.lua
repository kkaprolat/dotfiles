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
    git_add = utils.get_highlight("HeirlineGitAdd"),
    git_change = utils.get_highlight("HeirlineGitChange"),
    git_remove = utils.get_highlight("HeirlineGitRemove"),
}

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
        return { fg = self:mode_color().bg, bg = self:mode_color().fg, bold = true }
    end,
}
local function RightCapStatic(color)
    return {
        provider = "",
        hl = { fg = color.bg, bg = color.fg, bold = true }
    }
end
local LeftCapColored = {
    provider = "",
    hl = function(self)
        return { fg = self:mode_color().bg, bg = self:mode_color().fg, bold = true }
    end,
}
local function LeftCapStatic(color)
    return {
        provider = "",
        hl = { fg = color.bg, bg = color.fg, bold = true }
    }
end

local function SpaceStatic(color)
    return {
        provider = " ",
        hl = { fg = color.fg, bg = color.bg, bold = true }
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
    { -- edited
        provider = function() if vim.bo.modified then return "" else return "" end end,
    }, { -- modifiable
        provider = function() if (not vim.bo.modifiable) or vim.bo.readonly then return "" end end,
    }
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
            return self.status_dict.head
        end,
        hl = { fg = colors.white.fg, bg = colors.orange.bg }
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" +" .. count)
        end,
        hl = { fg = colors.git_add.fg, bg = colors.orange.bg }
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" -" .. count)
        end,
        hl = { fg = colors.git_remove.fg, bg = colors.orange.bg }
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" ~" .. count)
        end,
        hl = { fg = colors.git_change.fg, bg = colors.orange.bg }
    },
    {
        provider = " ",
        hl = 'HeirlineOrange'
    },
}

local Updates = {
    {
        condition = require'lazy.status'.has_updates,
        RightCapStatic(utils.get_highlight('HeirlineGitChange')),
    },
    {
        condition = require'lazy.status'.has_updates,
        provider = require'lazy.status'.updates,
        hl = { fg = colors.git_change.fg, bg = colors.git_change.bg }
    },
    {
        condition = require'lazy.status'.has_updates,
        LeftCapStatic(utils.get_highlight('HeirlineGitChange')),
    },
}


local SearchResults = {
    condition = function(self)
        local lines = vim.api.nvim_buf_line_count(0)
        if lines > 50000 then return end

        local query = vim.fn.getreg("/")
        if query == "" then return end

        if query:find("@") then return end

        local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1})
        local active = false
        if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
            active = true
        end
        if not active then return end

        query = query:gsub([[^\V]], "")
        query = query:gsub([[\<]], ""):gsub([[\>]], "")

        self.query = query
        self.count = search_count
        return true
    end,
    {
        RightCapStatic(colors.green),
        {
            provider = function(self)
                return table.concat({
                    ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
                })
            end,
            hl = colors.green
        },
        LeftCapStatic(colors.green),
    }
}



local DefaultStatusLine = {
    -- ViMode, FileNameBlock, RightCap, Space, Git, Align, Navic, LspMessages, Space, Diagnostics, Space, RightCap, SearchResults, ScrollBar
    ViMode, FileNameBlock, Space, Git, Space, Updates, Align, Diagnostics, Align, SearchResults, Space, ScrollBar
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


require'heirline'.setup({
    statusline = StatusLines,
--    winbar = ...,
--    tabline = ...,
--    statuscolumn = ...,
})
