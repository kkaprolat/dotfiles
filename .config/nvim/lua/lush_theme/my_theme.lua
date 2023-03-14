--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl
local colors = {}
local light = false

-- colors based on Catppuccin Mocha

local mocha = {
    rosewater =     hsl(10,     56,     91),
    flamingo =      hsl(0,      59,     88),
    pink =          hsl(316,    72,     86),
    mauve =         hsl(267,    84,     81),
    red =           hsl(343,    81,     75),
    maroon =        hsl(350,    56,     77),
    peach =         hsl(23,     92,     75),
    yellow =        hsl(41,     86,     83),
    green =         hsl(115,    54,     76),
    teal =          hsl(170,    57,     73),
    sky =           hsl(189,    71,     73),
    sapphire =      hsl(199,    76,     69),
    blue =          hsl(217,    92,     76),
    lavender =      hsl(232,    97,     85),
    text =          hsl(226,    63,     88),
    subtext1 =      hsl(227,    35,     80),
    subtext0 =      hsl(228,    24,     72),
    overlay2 =      hsl(228,    17,     64),
    overlay1 =      hsl(230,    13,     55),
    overlay0 =      hsl(231,    11,     47),
    surface2 =      hsl(233,    12,     39),
    surface1=       hsl(234,    13,     31),
    surface0 =      hsl(237,    16,     23),
    base =          hsl(240,    21,     15),
    mantle =        hsl(240,    21,     12),
    crust =         hsl(240,    23,     9),
}

-- colors based on Catppuccin Latte
local latte = {
    rosewater =     hsl(11,     59,     67),
    flamingo =      hsl(0,      60,     67),
    pink =          hsl(316,    73,     69),
    mauve =         hsl(266,    85,     58),
    red =           hsl(347,    87,     44),
    maroon =        hsl(355,    76,     59),
    peach =         hsl(22,     99,     52),
    yellow =        hsl(35,     77,     49),
    green =         hsl(109,    58,     40),
    teal =          hsl(183,    74,     35),
    sky =           hsl(197,    97,     46),
    sapphire =      hsl(189,    70,     42),
    blue =          hsl(220,    91,     54),
    lavender =      hsl(231,    97,     72),
    text =          hsl(234,    16,     35),
    subtext1 =      hsl(233,    13,     41),
    subtext0 =      hsl(233,    10,     47),
    overlay2 =      hsl(232,    10,     53),
    overlay1 =      hsl(231,    10,     59),
    overlay0 =      hsl(228,    11,     65),
    surface2 =      hsl(227,    12,     71),
    surface1=       hsl(225,    14,     77),
    surface0 =      hsl(223,    16,     83),
    base =          hsl(220,    23,     95),
    mantle =        hsl(220,    22,     92),
    crust =         hsl(220,    21,     89),
}

if light then
    colors = latte
else
    colors = mocha
end

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global

local theme = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        -- Lush.hsl provides a number of conveniece functions for:
        --
        --   Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
        --   Absolute adjustment (prefix above with abs_)
        --   Combination         (mix())
        --   Overrides           (hue(), saturation(), lightness())
        --   Access              (.h, .s, .l)
        --   Coercion            (tostring(), "Concatination: " .. color)
        --   Helpers             (readable())
        --
        --   Adjustment functions have shortcut aliases, ro, sa, de, li, da
        --                                               abs_sa, abs_de, abs_li, abs_da

        -- The following are all the Neovim default highlight groups from the docs
        -- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
        -- probably style all of these at a bare minimum.
        --
        -- Referenced/linked groups must come before being referenced/lined,
        -- so the order shown ((mostly) alphabetical) is likely
        -- not the order you will end up with.
        --
        -- You can uncomment these and leave them empty to disable any
        -- styling for that group (meaning they mostly get styled as Normal)
        -- or leave them commented to apply vims default colouring or linking.

        Comment                             { fg = colors.overlay2, gui = "italic" }, -- any comment
        -- ColorColumn                      { }, -- used for the columns set with 'colorcolumn'
        Conceal                             { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        -- Cursor                           { }, -- character under the cursor
        -- lCursor                          { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        -- CursorIM                         { }, -- like Cursor, but used when in IME mode |CursorIM|
        -- CursorColumn                     { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine                          { bg = colors.surface0 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory                           { }, -- directory names (and other special names in listings)
        diffAdded                           { fg = colors.green }, -- diff mode: Added line |diff.txt|
        diffRemoved                         { fg = colors.red }, -- diff mode: Added line |diff.txt|
        diffChanged                         { fg = colors.blue }, -- diff mode: Added line |diff.txt|
        diffOldFile                         { fg = colors.yellow }, -- diff mode: Added line |diff.txt|
        diffNewFile                         { fg = colors.peach }, -- diff mode: Added line |diff.txt|
        diffFile                            { fg = colors.blue }, -- diff mode: Added line |diff.txt|
        diffLine                            { fg = colors.overlay0 }, -- diff mode: Added line |diff.txt|
        diffIndexLine                       { fg = colors.teal }, -- diff mode: Added line |diff.txt|
        DiffAdd                             { bg = colors.green, fg = colors.crust  }, -- diff mode: Added line |diff.txt|
        DiffChange                          { bg = colors.blue, fg = colors.crust }, -- diff mode: Changed line |diff.txt|
        DiffDelete                          { bg = colors.red, fg = colors.crust }, -- diff mode: Deleted line |diff.txt|
        DiffText                            { DiffChange }, -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer                         { fg = colors.blue }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        -- TermCursor                       { }, -- cursor in a focused terminal
        -- TermCursorNC                     { }, -- cursor in an unfocused terminal
        ErrorMsg                            { bg = colors.red, fg = colors.crust }, -- error messages on the command line
        VertSplit                           { }, -- the column separating vertically split windows
        -- Folded                           { }, -- line used for closed folds
        -- FoldColumn                       { }, -- 'foldcolumn'
        SignColumn                          { }, -- column where |signs| are displayed
        IncSearch                           { gui = 'underline,bold', fg = colors.green }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Substitute                          { IncSearch, fg = colors.red }, -- |:substitute| replacement text highlighting
        LineNr                              { fg = colors.overlay2 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr                        { fg = colors.yellow, bg = CursorLine.bg, gui = 'bold' }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen                          { gui = "bold,underline" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg                          { }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea                          { }, -- Area for messages and cmdline
        -- MsgSeparator                     { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg                             { fg = colors.green, gui = 'bold' }, -- |more-prompt|
        NonText                             { fg = colors.blue, gui = 'bold' }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal                              { fg = colors.text }, -- normal text
        NormalFloat                         { fg = colors.subtext0, bg = colors.surface1 }, -- Normal text in floating windows.
        FloatBorder                         { fg = colors.blue },
        -- NormalNC                         { }, -- normal text in non-current windows
        Pmenu                               { NormalFloat }, -- Popup menu: normal item.
        PmenuSel                            { bg = colors.surface2, gui = 'bold'}, -- Popup menu: selected item.
        PmenuSbar                           { fg = colors.surface1 }, -- Popup menu: scrollbar.
        PmenuThumb                          { bg = colors.overlay0 }, -- Popup menu: Thumb of the scrollbar.
        Question                            { fg = colors.green, gui = "bold,italic" }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine                        { CursorLine }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search                              { IncSearch }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        -- SpecialKey                       { }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad                            { gui = 'undercurl', sp = colors.red }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise. 
        SpellCap                            { gui = 'undercurl', sp = colors.yellow }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal                          { gui = 'undercurl', sp = colors.blue }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare                           { gui = 'undercurl', sp = colors.green }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine                          { fg = colors.red }, -- status line of current window
        -- StatusLineNC                     { }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        -- TabLine                          { }, -- tab pages line, not active tab page label
        -- TabLineFill                      { }, -- tab pages line, where there are no labels
        -- TabLineSel                       { }, -- tab pages line, active tab page label
        Title                               { fg = colors.red, gui = "bold" }, -- titles for output from ":set all", ":autocmd" etc.
        Visual                              { fg = colors.peach, gui = "bold" }, -- Visual mode selection
        -- VisualNOS                        { }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg                          { fg = colors.red }, -- warning messages
        -- Whitespace                       { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        -- WildMenu                         { }, -- current match in 'wildmenu' completion

        -- These groups are not listed as default vim groups,
        -- but they are defacto standard group names for syntax highlighting.
        -- commented out groups should chain up to their "preferred" group by
        -- default,
        -- Uncomment and edit if you want more specific syntax highlighting.

        Error                               {  fg = colors.red }, -- (preferred) any erroneous construct

        Constant                            { fg = colors.peach }, -- (preferred) any constant
        String                              { fg = colors.green }, --   a string constant: "this is a string"
        Character                           { fg = colors.teal }, --  a character constant: 'c', '\n'
        Number                              { fg = colors.peach }, --   a number constant: 234, 0xff
        Boolean                             { fg = colors.peach }, --  a boolean constant: TRUE, false
        Float                               { Number }, --    a floating point constant: 2.3e10

        Identifier                          { fg = colors.flamingo }, -- (preferred) any variable name
        Function                            { fg = colors.blue }, -- function name (also: methods for classes)

        Statement                           { fg = colors.mauve }, -- (preferred) any statement
        Conditional                         { fg = colors.mauve }, --  if, then, else, endif, switch, etc.
        Repeat                              { fg = colors.mauve }, --   for, do, while, etc.
        Label                               { fg = colors.sapphire }, --    case, default, etc.
        Operator                            { fg = colors.sky }, -- "sizeof", "+", "*", etc.
        Keyword                             { fg = colors.mauve }, --  any other keyword
        -- Exception                        { }, --  try, catch, throw

        PreProc                             { fg = colors.pink }, -- (preferred) generic Preprocessor
        Include                             { fg = colors.mauve }, --  preprocessor #include
        Define                              { PreProc }, --   preprocessor #define
        Macro                               { fg = colors.mauve }, --    same as Define
        PreCondit                           { PreProc }, --  preprocessor #if, #else, #endif, etc.

        Type                                { fg = colors.yellow }, -- (preferred) int, long, char, etc.
        StorageClass                        { fg = colors.yellow }, -- static, register, volatile, etc.
        Structure                           { fg = colors.yellow }, --  struct, union, enum, etc.
        Typedef                             { Type }, --  A typedef

        Special                             { fg = colors.pink }, -- (preferred) any special symbol
        SpecialChar                         { Special }, --  special character in a constant
        Tag                                 { Special }, --    you can use CTRL-] on this
        Delimiter                           { Special }, --  character that needs attention
        SpecialComment                      { Special }, -- special things inside a comment
        Debug                               { Special }, --    debugging statements

        Underlined                          { gui = "underline" }, -- (preferred) text that stands out, HTML links
        Bold                                { gui = "bold" },
        Italic                              { gui = "italic" },

        -- treesitter syntax from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/treesitter.lua

        -- Misc
        sym"@comment"                       { Comment },
        sym"@error"                         { Error },
        sym"@preproc"                       { PreProc },
        sym"@define"                        { Define },
        sym"@operator"                      { Operator },

        -- Punctuation
        sym"@punctuation.delimiter"         { fg = colors.overlay2 },
        sym"@punctuation.bracket"           { fg = colors.overlay2 },
        sym"@punctuation.special"           { fg = colors.sky },

        -- Literals
        sym"@string"                        { String },
        sym"@string.regex"                  { fg = colors.peach },
        sym"@string.escape"                 { fg = colors.blue },

        sym"@character"                     { Character },
        sym"@character.special"             { SpecialChar },

        sym"@boolean"                       { Boolean },
        sym"@number"                        { Number },
        sym"@float"                         { Number },

        -- Functions
        sym"@function"                      { Function },
        sym"@function.builtin"              { fg = colors.peach },
        sym"@function.call"                 { sym"@function" },
        sym"@function.macro"                { fg = colors.teal },
        sym"@method"                        { fg = colors.peach },

        sym"@method.call"                   { sym"@method" },

        sym"@constructor"                   { fg = colors.sapphire },
        sym"@parameter"                     { fg = colors.maroon, gui = "italic" },

        -- Keywords
        sym"@keyword"                       { Keyword },
        sym"@keyword.function"              { fg = colors.mauve },
        sym"@keyword.operator"              { fg = colors.mauve },
        sym"@keyword.return"                { fg = colors.mauve },

        -- JS & derivative
        sym"@keyword.export"                { fg = colors.sky, gui = "bold" },

        sym"@conditional"                   { Conditional },
        sym"@repeat"                        { Repeat },

        -- debugging
        sym"@label"                         { Label },
        sym"@include"                       { Include },
        sym"@exception"                     { fg = colors.mauve },

        -- Types
        sym"@type"                          { Type },
        sym"@type.builtin"                  { fg = colors.yellow, gui = "italic" },
        sym"@type.definition"               { sym"@type" },
        sym"@type.qualifier"                { sym"@type" },

        sym"@storageclass"                  { StorageClass },
        sym"@attribute"                     { Constant },
        sym"@field"                         { fg = colors.lavender },
        sym"@property"                      { fg = colors.lavender },

        -- Identifiers
        sym"@variable"                      { fg = colors.text },
        sym"@variable.builtin"              { fg = colors.red },

        sym"@constant"                      { fg = colors.peach },
        sym"@constant.builtin"              { fg = colors.peach },
        sym"@constant.macro"                { Macro },

        sym"@namespace"                     { fg = colors.lavender, gui = "italic" },
        sym"@symbol"                        { fg = colors.flamingo },

        -- Text
        sym"@text"                          { fg = colors.text },
        sym"@text.strong"                   { fg = colors.maroon, gui = "bold" },
        sym"@text.emphasis"                 { fg = colors.maroon, gui = "italic" },
        sym"@text.underline"                { Underlined },
        sym"@text.strike"                   { fg = colors.text, gui = "strikethrough" },
        sym"@text.title"                    { fg = colors.blue, gui = "bold" },
        sym"@text.literal"                  { fg = colors.teal },
        sym"@text.uri"                      { fg = colors.rosewater, gui = "italic,underline" },
        sym"@text.math"                     { fg = colors.blue },
        sym"@text.environment"              { fg = colors.pink },
        sym"@text.environment.name"         { fg = colors.blue },
        sym"@text.reference"                { fg = colors.lavender, gui = "bold" },


        sym"@text.todo"                     { fg = colors.base, bg = colors.yellow },
        sym"@text.todo.checked"             { fg = colors.green },
        sym"@text.todo.unchecked"           { fg = colors.overlay1 },
        sym"@text.note"                     { fg = colors.base, bg = colors.blue },
        sym"@text.warning"                  { fg = colors.base, bg = colors.yellow },
        sym"@text.danger"                   { fg = colors.base, bg = colors.red },

        sym"@text.diff.add"                 { diffAdded },
        sym"@text.diff.delete"              { diffRemoved },

        -- Tags
        sym"@tag"                           { fg = colors.mauve },
        sym"@tag.attribute"                 { fg = colors.teal, gui = "italic" },
        sym"@tag.delimiter"                 { fg = colors.sky },

        -- Semantic tokens
        sym"@class"                         { fg = colors.blue },
        sym"@struct"                        { fg = colors.blue },
        sym"@enum"                          { fg = colors.teal },
        sym"@enumMember"                    { fg = colors.flamingo },
        sym"@event"                         { fg = colors.flamingo },
        sym"@interface"                     { fg = colors.flamingo },
        sym"@modifier"                      { fg = colors.flamingo },
        sym"@regexp"                        { fg = colors.pink },
        sym"@typeParamter"                  { fg = colors.yellow },
        sym"@decorator"                     { fg = colors.flamingo },

        -- Language specific
        -- css
        sym"@property.css"                  { fg = colors.lavender },
        sym"@property.id.css"               { fg = colors.blue },
        sym"@property.class.css"            { fg = colors.yellow },
        sym"@type.css"                      { fg = colors.lavender },
        sym"@type.tag.css"                  { fg = colors.mauve },
        sym"@string.plain.css"              { fg = colors.peach },
        sym"@number.css"                    { fg = colors.peach },

        -- toml
        sym"@property.toml"                 { fg = colors.blue },

        -- json
        sym"@label.json"                    { fg = colors.blue },

        -- lua
        sym"@constructor.lua"               { fg = colors.flamingo },

        -- typescript
        sym"@constructor.typescript"        { fg = colors.lavender },

        -- TSX (Typescript React)
        sym"@constructor.tsx"               { fg = colors.lavender },
        sym"@tag.attribute.tsx"             { fg = colors.mauve, gui = "italic" },

        -- cpp
        sym"@property.cpp"                  { fg = colors.rosewater },

        -- yaml
        sym"@field.yaml"                    { fg = colors.blue },

        -- ruby
        sym"@symbol.ruby"                   { fg = colors.flamingo },

        -- PHP
        sym"@type.qualifier.php"            { fg = colors.pink },

        -- ("Ignore", below, may be invisible...)
        -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|


        Todo                                { bg = colors.yellow, fg = colors.base,  gui = "bold,italic" }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- LspReferenceText                 { }, -- used for highlighting "text" references
        -- LspReferenceRead                 { }, -- used for highlighting "read" references
        -- LspReferenceWrite                { }, -- used for highlighting "write" references
        -- LspCodeLens                      { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        -- LspCodeLensSeparator             { } , -- Used to color the seperator between two or more code lens.
        -- LspSignatureActiveParameter      { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        DiagnosticError                     { fg = colors.red, bg = 'NONE' }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticWarn                      { fg = colors.peach, bg = 'NONE' }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticInfo                      { fg = colors.text, bg = 'NONE' }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticHint                      { fg = colors.blue, bg = 'NONE' }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticVirtualTextError          { DiagnosticError, gui = "italic" } , -- Used for "Error" diagnostic virtual text.
        DiagnosticVirtualTextWarn           { DiagnosticWarn, gui = "italic" } , -- Used for "Warn" diagnostic virtual text.
        DiagnosticVirtualTextInfo           { DiagnosticInfo, gui = "italic" } , -- Used for "Info" diagnostic virtual text.
        DiagnosticVirtualTextHint           { DiagnosticHint, gui = "italic" } , -- Used for "Hint" diagnostic virtual text.
        DiagnosticUnderlineError            {  DiagnosticError, gui = "underline" }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn             {  DiagnosticWarn, gui = "underline" }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo             {  DiagnosticInfo, gui = "underline" }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint             {  DiagnosticHint, gui = "underline" }, -- Used to underline "Hint" diagnostics
        DiagnosticFloatingError             { DiagnosticVirtualTextError } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        DiagnosticFloatingWarn              { DiagnosticVirtualTextWarn } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        DiagnosticFloatingInfo              { DiagnosticVirtualTextInfo } , -- Used to color "Info" diagnostic messages in diagnostics float.
        DiagnosticFloatingHint              { DiagnosticVirtualTextHint } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        DiagnosticSignError                 { DiagnosticError, gui = "bold" }, -- Used for "Error" signs in sign column
        DiagnosticSignWarn                  { DiagnosticWarn, gui = "bold" }, -- Used for "Warning" signs in sign column
        DiagnosticSignInfo                  { DiagnosticInfo, gui = "bold" }, -- Used for "Information" signs in sign column
        DiagnosticSignHint                  { DiagnosticHint, gui = "bold" }, -- Used for "Hint" signs in sign column

        -- gitsigns
        GitSignsAdd                         { fg = colors.green, gui = "bold" },
        GitSignsChange                      { fg = colors.yellow, gui = "bold" },
        GitSignsDelete                      { fg = colors.red, gui = "bold" },


        -- barbar.nvim
        -- adapted from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/barbar.lua

        BufferCurrent                       { bg = colors.surface2, fg = colors.text },    -- current buffer
        BufferCurrentIndex                  { bg = colors.surface2, fg = colors.blue },    -- current buffer, buffer index
        BufferCurrentMod                    { bg = colors.surface2, fg = colors.teal, gui = "bold" },    -- current buffer, when modified
        BufferCurrentSign                   { bg = colors.surface2, fg = colors.blue },    -- current buffer, separator between buffers
        BufferCurrentTarget                 { bg = colors.surface2, fg = colors.red },    -- current buffer, letter in buffer-picking mode
        BufferVisible                       { bg = colors.surface1, fg = colors.text },    -- buffer visible but not current
        BufferVisibleIndex                  { bg = colors.surface1, fg = colors.blue },
        BufferVisibleMod                    { bg = colors.surface1, fg = colors.teal, gui = "bold" },
        BufferVisibleSign                   { bg = colors.surface1, fg = colors.blue },
        BufferVisibleTarget                 { bg = colors.surface1, fg = colors.red },
        BufferInactive                      { bg = colors.surface1, fg = colors.text },    -- buffer invisible and not current
        BufferInactiveIndex                 { bg = colors.surface1, fg = colors.text },
        BufferInactiveMod                   { bg = colors.surface1, fg = colors.teal, gui = "bold" },
        BufferInactiveSign                  { bg = colors.surface1, fg = colors.blue },
        BufferInactiveTarget                { bg = colors.surface1, fg = colors.red },
        BufferTabpages                      {  },    -- tabpage indicator
        BufferTabpageFill                   {  },    -- filler after the buffer section
        -- BufferOffset                     { },    -- offset section, created with set_offset()

        -- indent-blankline.nvim

        IndentBlankLineChar                 { fg = colors.overlay1 }, -- highlight of indent character
        IndentBlanklineSpaceChar            { IndentBlankLineChar }, -- highlight of space character
        IndentBlanklineSpaceCharBlankline   { IndentBlankLineChar }, -- highlight of space character on blank lines.
        IndentBlankLineContextChar          { fg = colors.overlay0 }, -- highlight of indent character when base of current context. Only used when g:indent_blankline_show_current_context is active

        Heirline                            { fg = colors.base, bg = colors.green },
        HeirlineRed                         { fg = colors.base, bg = colors.red },
        HeirlineWhite                       { fg = colors.base, bg = colors.text },
        HeirlineGreen                       { fg = colors.base, bg = colors.green },
        HeirlineBlue                        { fg = colors.base, bg = colors.blue },
        HeirlineGray                        { fg = colors.base, bg = colors.overlay0 },
        HeirlineOrange                      { fg = colors.base, bg = colors.peach },
        HeirlinePurple                      { fg = colors.base, bg = colors.lavender },
        HeirlineCyan                        { fg = colors.base, bg = colors.blue },
        HeirlineYellow                        { fg = colors.base, bg = colors.yellow },
        HeirlineGitAdd                      { fg = colors.green, bg = colors.base },
        HeirlineGitRemove                   { fg = colors.red, bg = colors.base },
        HeirlineGitChange                   { fg = colors.yellow, bg = colors.base },
        HeirlineError                       { bg = DiagnosticError.fg, fg = colors.base },
        HeirlineWarn                        { bg = DiagnosticWarn.fg, fg = colors.base },
        HeirlineInfo                        { bg = DiagnosticInfo.fg, fg = colors.base },
        HeirlineHint                        { bg = DiagnosticHint.fg, fg = colors.base },

        -- from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/notify.lua
        NotifyERRORBorder                   { fg = colors.red },
        NotifyERRORIcon                     { fg = colors.red },
        NotifyERRORTitle                    { fg = colors.red, gui = "italic" },
        NotifyWARNBorder                    { fg = colors.yellow },
        NotifyWARNIcon                      { fg = colors.yellow },
        NotifyWARNTitle                     { fg = colors.yellow, gui = "italic" },
        NotifyINFOBorder                    { fg = colors.blue },
        NotifyINFOIcon                      { fg = colors.blue },
        NotifyINFOTitle                     { fg = colors.blue, gui = "italic" },
        NotifyDEBUGBorder                   { fg = colors.peach },
        NotifyDEBUGIcon                     { fg = colors.peach },
        NotifyDEBUGTitle                    { fg = colors.peach, gui = "italic" },
        NotifyTRACEBorder                   { fg = colors.rosewater },
        NotifyTRACEIcon                     { fg = colors.rosewater },
        NotifyTRACETitle                    { fg = colors.rosewater, gui = "italic" },
        NotifyBackground                    { bg = colors.crust },

        -- from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/noice.lua
        NoiceCmdline                        { fg = colors.text },
        NoiceCmdlineIcon                    { fg = colors.sky },
        NoiceCmdlineIconSearch              { fg = colors.yellow },
        NoiceCmdlinePopup                   { fg = colors.text },
        NoiceCmdlinePopupBorder             { fg = colors.lavender },
        NoiceCmdlinePopupBorderSearch       { fg = colors.yellow },
        NoiceConfirm                        { fg = colors.text },
        NoiceConfirmBorder                  { fg = colors.blue },
        NoiceCursor                         { fg = colors.text },
        NoiceMini                           { fg = colors.text },
        NoicePopup                          { fg = colors.text },
        NoicePopupBorder                    { FloatBorder },
        NoicePopupmenu                      { Pmenu },
        NoicePopupmenuBorder                { FloatBorder },
        NoicePopupmenuMatch                 { Special },
        NoicePopupmenuSelected              { PmenuSel },
        NoiceScrollbar                      { PmenuSbar },
        NoiceScrollbarThumb                 { PmenuThumb },
        NoiceSplit                          { fg = colors.text, bg = Normal.bg },
        NoiceSplitBorder                    { FloatBorder },
        NoiceVirtualText                    { DiagnosticVirtualTextInfo },

        -- Asciidoctor
        asciidocQuotedMonospaced2           { fg = colors.blue },
        asciidocQuotedBold                  { fg = colors.text, gui = "bold" },
        asciidocQuotedUnconstrainedBold     { asciidocQuotedBold },

        -- Cmp (from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/cmp.lua)
        CmpItemAbbr                         { fg = colors.overlay2 },
        CmpItemAbbrDeprecated               { fg = colors.overlay0, gui = "strikethrough" },
        CmpItemKind                         { fg = colors.blue },
        CmpItemMenu                         { fg = colors.text },
        CmpItemAbbrMatch                    { fg = colors.text },
        CmpItemAbbrMatchFuzzy               { fg = colors.text },

        CmpItemKindSnippet                  { fg = colors.mauve },
        CmpItemKindKeyword                  { fg = colors.red },
        CmpItemKindColor                    { fg = colors.red },
        CmpItemKindReference                { fg = colors.red },
        CmpItemKindEnumMember               { fg = colors.red },
        CmpItemKindText                     { fg = colors.teal },
        CmpItemKindMethod                   { fg = colors.blue },
        CmpItemKindConstructor              { fg = colors.blue },
        CmpItemKindFunction                 { fg = colors.blue },
        CmpItemKindFolder                   { fg = colors.blue },
        CmpItemKindModule                   { fg = colors.blue },
        CmpItemKindFile                     { fg = colors.blue },
        CmpItemKindStruct                   { fg = colors.blue },
        CmpItemKindEvent                    { fg = colors.blue },
        CmpItemKindOperator                 { fg = colors.blue },
        CmpItemKindTypeParameter            { fg = colors.blue },
        CmpItemKindConstant                 { fg = colors.peach },
        CmpItemKindValue                    { fg = colors.peach },
        CmpItemKindField                    { fg = colors.green },
        CmpItemKindProperty                 { fg = colors.green },
        CmpItemKindEnum                     { fg = colors.green },
        CmpItemKindUnit                     { fg = colors.green },
        CmpItemKindClass                    { fg = colors.yellow },
        CmpItemKindInterface                { fg = colors.yellow },
        CmpItemKindVariable                 { fg = colors.flamingo },

        -- from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/which_key.lua
        WhichKey                            { fg = colors.flamingo },
        WhichKeyGroup                       { fg = colors.blue },
        WhichKeySeperator                   { fg = colors.overlay0 },
        WhichKeyDesc                        { fg = colors.pink },
        WhichKeyBorder                      { fg = colors.blue },
        WhichKeyValue                       { fg = colors.overlay0 },
        WhichKeyFloat                       { Normal },

        -- from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/lsp_saga.lua
        -- LSPSaga
        TitleString { },
        TitleIcon { },
        SagaBorder { },
        SagaNormal { },
        SagaExpand { },
        SagaCollapse { },
        SagaCount { },
        SagaBeacon { },
        ActionPreviewTitle { },
        CodeActionText { },
        CodeActionNumber { },
        FinderSelection { },
        FinderFileName { },
        FinderIcon { },
        FinderCount { },
        FinderType { },
        FinderSpinnerTitle { },
        FinderSpinner { },
        FinderVirtText { },
        RenameNormal { },
        DiagnosticSource { },
        DiagnosticPos { },
        DiagnosticWord { },
        DiagnosticHead { },
        CallHierarchyIcon { },
        CallHierarchyTitle { },
        SagaShadow { },
        OutlineIndent { },

        -- LSPKind
        LspKindClass { },
        LspKindConstant { },
        LspKindConstructor { },
        LspKindEnum { },
        LspKindEnumMember { },
        LspKindEvent { },
        LspKindField { },
        LspKindFile { },
        LspKindFunction { },
        LspKindInterface { },
        LspKindKey { },
        LspKindMethod { },
        LspKindModule { },
        LspKindNamespace { },
        LspKindNumber { },
        LspKindOperator { },
        LspKindPackage { },
        LspKindProperty { },
        LspKindStruct { },
        LspKindTypeParameter { },
        LspKindVariable { },
        LspKindArray { },
        LspKindBoolean { },
        LspKindNull { },
        LspKindObject { },
        LspKindString { },
        LspKindTypeAlias { },
        LspKindParameter { },
        LspKindStaticMethod { },
        LspKindText { },
        LspKindSnippet { },
        LspKindFolder { },
        LspKindUnit { },
        LspKindValue { },



}
end)


-- return our parsed theme for extension or use else where.
return theme

-- vi: ts=4
