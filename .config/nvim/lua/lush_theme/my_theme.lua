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

-- colors based on Catpuccin Mocha

colors = {
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

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global

local theme = lush(function()
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
        DiffAdd                             { bg = colors.green, fg = colors.crust  }, -- diff mode: Added line |diff.txt|
        DiffChange                          { bg = colors.yellow, fg = colors.crust }, -- diff mode: Changed line |diff.txt|
        DiffDelete                          { bg = colors.red, fg = colors.crust }, -- diff mode: Deleted line |diff.txt|
        DiffText                            { DiffDelete }, -- diff mode: Changed text within a changed line |diff.txt|
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
        -- NormalNC                         { }, -- normal text in non-current windows
        Pmenu                               { NormalFloat }, -- Popup menu: normal item.
        PmenuSel                            { bg = colors.surface2, gui = 'bold'}, -- Popup menu: selected item.
        PmenuSbar                           { fg = colors.green }, -- Popup menu: scrollbar.
        -- PmenuThumb                       { }, -- Popup menu: Thumb of the scrollbar.
        Question                            { fg = colors.green, gui = "bold,italic" }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine                        { CursorLine }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search                              { IncSearch }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        -- SpecialKey                       { }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        -- SpellBad                         { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise. 
        -- SpellCap                         { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        -- SpellLocal                       { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        -- SpellRare                        { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
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

        Constant                            { fg = colors.red }, -- (preferred) any constant
        String                              { Constant }, --   a string constant: "this is a string"
        -- Character                        { }, --  a character constant: 'c', '\n'
        Number                              { Constant }, --   a number constant: 234, 0xff
        Boolean                             { Constant }, --  a boolean constant: TRUE, false
        -- Float                            { }, --    a floating point constant: 2.3e10

        Identifier                          { Normal }, -- (preferred) any variable name
        Function                            { fg = colors.blue }, -- function name (also: methods for classes)

        Statement                           { fg = colors.yellow, gui = "bold" }, -- (preferred) any statement
        -- Conditional                      { }, --  if, then, else, endif, switch, etc.
        -- Repeat                           { }, --   for, do, while, etc.
        -- Label                            { }, --    case, default, etc.
        Operator                            { Statement }, -- "sizeof", "+", "*", etc.
        Keyword                             { Statement }, --  any other keyword
        -- Exception                        { }, --  try, catch, throw

        PreProc                             { fg = colors.lavender }, -- (preferred) generic Preprocessor
        Include                             { PreProc }, --  preprocessor #include
        -- Define                           { }, --   preprocessor #define
        -- Macro                            { }, --    same as Define
        -- PreCondit                        { }, --  preprocessor #if, #else, #endif, etc.

        Type                                { fg = colors.green, gui = "bold" }, -- (preferred) int, long, char, etc.
        -- StorageClass                     { }, -- static, register, volatile, etc.
        -- Structure                        { }, --  struct, union, enum, etc.
        Structure                           { Type }, --  struct, union, enum, etc.
        -- Typedef                          { }, --  A typedef

        Special                             { fg = colors.peach }, -- (preferred) any special symbol
        -- SpecialChar                      { }, --  special character in a constant
        -- Tag                              { }, --    you can use CTRL-] on this
        -- Delimiter                        { }, --  character that needs attention
        -- SpecialComment                   { }, -- special things inside a comment
        -- Debug                            { }, --    debugging statements

        Underlined                          { gui = "underline" }, -- (preferred) text that stands out, HTML links
        -- Bold                             { gui = "bold" },
        -- Italic                           { gui = "italic" },

        -- ("Ignore", below, may be invisible...)
        -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

        Error                               { bg = colors.red, fg = colors.crust }, -- (preferred) any erroneous construct

        Todo                                { fg = colors.yellow,  gui = "bold,italic" }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

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
        DiagnosticError                     { fg = colors.red }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticWarn                      { fg = colors.peach }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticInfo                      { fg = colors.text }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        DiagnosticHint                      { fg = colors.blue }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        -- DiagnosticVirtualTextError       { } , -- Used for "Error" diagnostic virtual text.
        -- DiagnosticVirtualTextWarn        { } , -- Used for "Warn" diagnostic virtual text.
        -- DiagnosticVirtualTextInfo        { } , -- Used for "Info" diagnostic virtual text.
        -- DiagnosticVirtualTextHint        { } , -- Used for "Hint" diagnostic virtual text.
        DiagnosticUnderlineError            {  DiagnosticError, gui = "underline" }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn             {  DiagnosticWarn, gui = "underline" }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo             {  DiagnosticInfo, gui = "underline" }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint             {  DiagnosticHint, gui = "underline" }, -- Used to underline "Hint" diagnostics
        -- DiagnosticFloatingError          { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn           { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo           { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint           { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        DiagnosticSignError                 { DiagnosticError, gui = "bold" }, -- Used for "Error" signs in sign column
        DiagnosticSignWarn                  { DiagnosticWarn, gui = "bold" }, -- Used for "Warning" signs in sign column
        DiagnosticSignInfo                  { DiagnosticInfo, gui = "bold" }, -- Used for "Information" signs in sign column
        DiagnosticSignHint                  { DiagnosticHint, gui = "bold" }, -- Used for "Hint" signs in sign column

        -- These groups are for the neovim tree-sitter highlights.
        -- As of writing, tree-sitter support is a WIP, group names may change.
        -- By default, most of these groups link to an appropriate Vim group,
        -- TSError -> Error for example, so you do not have to define these unless
        -- you explicitly want to support Treesitter's improved syntax awareness.
        -- See :h nvim-treesitter-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- TSAttribute                      { } , -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.

        -- TSBoolean                        { } , -- Boolean literals: `True` and `False` in Python.

        -- TSCharacter                      { } , -- Character literals: `'a'` in C.
        -- TSComment                        { } , -- Line comments and block comments.
        -- TSConditional                    { } , -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
        -- TSConstant                       { } , -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
        -- TSConstBuiltin                   { } , -- Built-in constant values: `nil` in Lua.
        -- TSConstMacro                     { } , -- Constants defined by macros: `NULL` in C.
        -- TSConstructor                    { } , -- Constructor calls and definitions: `{}` in Lua, and Java constructors.

        -- TSError                          { } , -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
        -- TSException                      { } , -- Exception related keywords: `try`, `except`, `finally` in Python.

        -- TSField                             { } , -- Object and struct fields.
        -- TSFloat                          { } , -- Floating-point number literals.
        -- TSFunction                       { } , -- Function calls and definitions.
        -- TSFuncBuiltin                    { } , -- Built-in functions: `print` in Lua.
        -- TSFuncMacro                      { } , -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.

        -- TSInclude                        { } , -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.

        -- TSKeyword                           { Statement } , -- Keywords that don't fit into other categories.
        -- TSKeywordFunction                { } , -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
        -- TSKeywordOperator                { } , -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
        -- TSKeywordReturn                  { } , -- Keywords like `return` and `yield`.

        -- TSLabel                          { } , -- GOTO labels: `label:` in C, and `::label::` in Lua.

        -- TSMethod                         { } , -- Method calls and definitions.
        -- Method                              { Identifier },

        -- TSNamespace                         { Include }, -- Identifiers referring to modules and namespaces.
        -- TSNone                           { } , -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
        -- TSNumber                         { } , -- Numeric literals that don't fit into other categories.

        -- TSOperator                       { } , -- Binary or unary operators: `+`, and also `->` and `*` in C.

        -- TSParameter                      { } , -- Parameters of a function.
        -- TSParameterReference             { } , -- References to parameters of a function.
        -- TSProperty                          { } , -- Same as `TSField`.
        -- TSPunctDelimiter                 { } , -- Punctuation delimiters: Periods, commas, semicolons, etc.
        -- TSPunctBracket                   { } , -- Brackets, braces, parentheses, etc.
        -- TSPunctSpecial                   { } , -- Special punctuation that doesn't fit into the previous categories.

        -- TSRepeat                         { } , -- Keywords related to loops: `for`, `while`, etc.

        -- TSString                         { } , -- String literals.
        -- TSStringRegex                    { } , -- Regular expression literals.
        -- TSStringEscape                   { } , -- Escape characters within a string: `\n`, `\t`, etc.
        -- TSStringSpecial                  { } , -- Strings with special meaning that don't fit into the previous categories.
        -- TSSymbol                         { } , -- Identifiers referring to symbols or atoms.

        -- TSTag                            { } , -- Tags like HTML tag names.
        -- TSTagAttribute                   { } , -- HTML tag attributes.
        -- TSTagDelimiter                   { } , -- Tag delimiters like `<` `>` `/`.
        -- TSText                           { } , -- Non-structured text. Like text in a markup language.

        -- TSStrong                         { } , -- Text to be represented in bold.
        -- TSEmphasis                       { } , -- Text to be represented with emphasis.
        -- TSUnderline                      { } , -- Text to be represented with an underline.
        -- TSStrike                         { } , -- Strikethrough text.
        -- TSTitle                             { Title } , -- Text that is part of a title.
        -- TSLiteral                        { } , -- Literal or verbatim text.
        -- TSURI                            { } , -- URIs like hyperlinks or email addresses.
        -- TSMath                           { } , -- Math environments like LaTeX's `$ ... $`
        -- TSTextReference                  { } , -- Footnotes, text references, citations, etc.
        -- TSEnvironment                    { } , -- Text environments of markup languages.
        -- TSEnvironmentName                { } , -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
        -- TSNote                           { } , -- Text representation of an informational note.
        -- TSWarning                        { } , -- Text representation of a warning note.
        -- TSDanger                         { } , -- Text representation of a danger note.
        -- TSType                           { } , -- Type (and class) definitions and annotations.
        -- TSTypeBuiltin                    { } , -- Built-in types: `i32` in Rust.
        -- TSVariable                          { fg = Normal.fg } , -- Variable names that don't fit into other categories.
        -- TSVariableBuiltin                { } , -- Variable names defined by the language: `this` or `self` in Javascript.

        -- gitsigns
        GitSignsAdd                         { fg = colors.green, gui = "bold" },
        GitSignsChange                      { fg = colors.yellow, gui = "bold" },
        GitSignsDelete                      { fg = colors.red, gui = "bold" },


        -- barbar.nvim

        BufferCurrent                       { fg = colors.blue, bg = colors.bg4 },    -- current buffer
        BufferCurrentIndex                  { BufferCurrent },    -- current buffer, buffer index
        BufferCurrentMod                    { BufferCurrent, gui = "bold" },    -- current buffer, when modified
        BufferCurrentSign                   { BufferCurrent },    -- current buffer, separator between buffers
        BufferCurrentTarget                 { BufferCurrent },    -- current buffer, letter in buffer-picking mode
        BufferVisible                       { fg = colors.green, bg = colors.bg4 },    -- buffer visible but not current
        BufferVisibleIndex                  { BufferVisible },
        BufferVisibleMod                    { BufferVisible, gui = "bold" },
        BufferVisibleSign                   { BufferVisible },
        BufferVisibleTarget                 { BufferVisible },
        BufferInactive                      { fg = colors.lavender, bg = colors.bg },    -- buffer invisible and not current
        BufferInactiveIndex                 { BufferInactive },
        BufferInactiveMod                   { BufferInactive, gui = "bold" },
        BufferInactiveSign                  { BufferInactive },
        BufferInactiveTarget                { BufferInactive },
        BufferTabpages                      { bg = colors.bg },    -- tabpage indicator
        BufferTabpageFill                   { bg = colors.bg },    -- filler after the buffer section
        -- BufferOffset                     { },    -- offset section, created with set_offset()

        -- indent-blankline.nvim

        IndentBlankLineChar                 { fg = colors.overlay1 }, -- highlight of indent character
        IndentBlanklineSpaceChar            { IndentBlankLineChar }, -- highlight of space character
        IndentBlanklineSpaceCharBlankline   { IndentBlankLineChar }, -- highlight of space character on blank lines.
        IndentBlankLineContextChar          { fg = colors.overlay0 }, -- highlight of indent character when base of current context. Only used when g:indent_blankline_show_current_context is active

        Heirline                            { bg = colors.green, fg = colors.red },
        HeirlineRed                         { fg = colors.red },
        HeirlineWhite                       { fg = colors.text },
        HeirlineGreen                       { fg = colors.green },
        HeirlineBlue                        { fg = colors.blue },
        HeirlineGray                        { fg = colors.overlay0 },
        HeirlineOrange                      { fg = colors.peach },
        HeirlinePurple                      { fg = colors.lavender },
        HeirlineCyan                        { fg = colors.blue },
        HeirlineGitAdd                      { fg = colors.green },
        HeirlineGitRemove                   { fg = colors.red },
        HeirlineGitChange                   { fg = colors.yellow },

        NotifyBackground                    { bg = colors.crust },


}
end)


-- return our parsed theme for extension or use else where.
return theme

-- vi: ts=4
