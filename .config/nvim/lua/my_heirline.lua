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
        provider = "┃ ",
        hl = function(self)
                return { fg = self:mode_color().fg, bg = self:mode_color().bg, bold = true }
        end,
}
local function RightCapStatic(color)
        local col = utils.get_highlight('Heirline'..color)
        return {
                provider = "┃ ",
                hl = { fg = col.fg, bg = col.bg, bold = true }
        }
end

-- left

local ViMode = { RightCapColored, {
        -- Now we define some dictionaries to map the output of mode() to the
        -- corresponding string. We can put these into `static` to compute
        -- them at initialization time.
        static = {
                mode_names = { -- change the strings if you like it verbose
                        n = "NORMAL",
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
                return "%2(" .. self.mode_names[vim.fn.mode(1)] .. " %)"
        end,
        -- Same goes for the highlight. Now the background will change according to the current mode.
        hl = function(self)
                local color = self:mode_color()
                return { bg = color.bg, fg = color.fg, bold = true, }
        end,
        -- Re-evaluate the component only on ModeChanged event.
        -- This is not required in any way, but it's there, and it's a small
        -- performance improvement.
        update = 'ModeChanged'
}}

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
                return self.icon and (' ' .. self.icon .. ' ')
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

local FileFlags = {
        { -- edited
                provider = function() if vim.bo.modified then return "  " else return "   " end end,
        }, { -- modifiable
                provider = function() if (not vim.bo.modifiable) or vim.bo.readonly then return " " end end,
        }
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


-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
        FileNameBlock,
        RightCapStatic('White'),
        FileIcon,
        FileName,
        FileFlags, -- A small optimisation, since their parent does nothing
        FileSize,
        { provider = '%<' }-- this means that the statusline is cut here when there's not enough space
)

-- right
local ScrollBar = {
        provider = " %P - %l:%c ",
        hl = function(self)
                return { bg = self:mode_color().bg, fg = utils.get_highlight("Heirline").bg }
        end,
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
                provider = function(self)
                        -- 0 is just another output, we can decide to print it or not!
                        return self.errors > 0 and (self.error_icon .. self.errors .. "  ")
                end,
                hl = "DiagnosticError"
        },
        {
                provider = function(self)
                        return self.warnings > 0 and (self.warn_icon .. self.warnings .. "  ")
                end,
                hl = "DiagnosticWarn"
        },
        {
                provider = function(self)
                        return self.info > 0 and (self.info_icon .. self.info .. "  ")
                end,
                hl = "DiagnosticInfo"
        },
        {
                provider = function(self)
                        return self.hints > 0 and (self.hint_icon .. self.hints .. "  ")
                end,
                hl = "DiagnosticHint"
        },
}

-- local Navic = {
--         condition = require'nvim-navic'.is_available,
-- --        provider = require'nvim-navic'.get_location,
--         static = {
--                 -- create a type highlight map
--                 type_hl = {
--                         File = "Directory",
--                         Module = "Include",
--                         Namespace = "TSNamespace",
--                         Package = "Include",
--                         Class = "Struct",
--                         Method = "Method",
--                         Property = "TSProperty",
--                         Field = "TSField",
--                         Constructor = "TSConstructor ",
--                         Enum = "TSField",
--                         Interface = "Type",
--                         Function = "Function",
--                         Variable = "TSVariable",
--                         Constant = "Constant",
--                         String = "String",
--                         Number = "Number",
--                         Boolean = "Boolean",
--                         Array = "TSField",
--                         Object = "Type",
--                         Key = "TSKeyword",
--                         Null = "Comment",
--                         EnumMember = "TSField",
--                         Struct = "Struct",
--                         Event = "Keyword",
--                         Operator = "Operator",
--                         TypeParameter = "Type",
--                 },
--         },
--         init = function(self)
--                 local data = require'nvim-navic'.get_data() or {}
--                 local children = {}
--                 -- create a child for each level
--                 for i, d in ipairs(data) do
--                         local child = {
--                                 {
--                                         provider = d.icon,
--                                         hl = self.type_hl[d.type]
--                                 },
--                                 {
--                                         provider = d.name,
--                                         -- highlight icon only or location name as well
--                                         -- hl = self.type_hl[d.type]
--                                 },
--                         }
--                         -- add a separator only if needed
--                         if #data > 1 and i < #data then
--                                 table.insert(child, {
--                                         provider = " > "
--                                 })
--                         end
--                         table.insert(children, child)
--                 end
--                 -- instantiate the new child
--                 self[1] = self:new(children, 1)
--         end,
--         hl = { fg = utils.get_highlight("Heirline").fg }
-- }

local Git = {
        condition = conditions.is_git_repo,

        init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
        end,
        -- hl = {}
        RightCapStatic('orange'),
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
                provider = function(self)
                        return table.concat({
                                ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
                        })
                end,
                hl = function(self)
                        return { bg = self:mode_color().bg, fg = utils.get_highlight("Heirline").bg }
                end,
        }
}



local DefaultStatusLine = {
        -- ViMode, FileNameBlock, RightCap, Space, Git, Align, Navic, LspMessages, Space, Diagnostics, Space, RightCap, SearchResults, ScrollBar
        ViMode, Space, FileNameBlock, Space, Git
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

require 'heirline'.setup(StatusLines)
