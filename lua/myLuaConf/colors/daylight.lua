-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

local black = hsl(0, 0, 0)
local white = hsl(255, 255, 255)
local strong_gray = white.darken(60).desaturate(100)
local mid_gray = white.darken(45).desaturate(100)
local weak_gray = white.darken(25).desaturate(100)
local debug  = hsl(300, 100, 50)
local debug2 = hsl(272, 91, 75)
local debug3 = hsl(192, 100, 39)
local debug4 = hsl(91, 81, 73)



-- TODO:
-- @ WIP:
-- @ Make comments italics
-- 
--
-- o NEXT:
-- o replace fg=white,bg=black with gui=reverse?
-- o Extra config for autocomplete window
--     o Currently selected line should be black bg, white fg (in light mode)
--     o Black border around the autocomplete pop-up
-- o Support colors for embedded yazi
-- o Support colors for embedded lazygit
-- o Extra config for telescope
--     o Currently selected line should be black bg, white fg (in light mode)
-- o Make indent guides weak_gray
-- o Review `unused` sections below


-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
-- @diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    -- SECTION: Verified
    --
    Normal { fg = black, bg = white }, -- Normal text
    Visual { fg = white, bg = black }, -- Visual mode selection
    VisualNOS { fg = white, bg = black }, -- Visual mode selection when vim is "Not Owning the Selection".
    EndOfBuffer { fg = white, bg = strong_gray }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    CurSearch { fg = white, bg = Normal.fg,  }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    IncSearch { fg = white, bg = strong_gray }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Search { fg = white, bg = strong_gray }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    Substitute { fg = white, bg = strong_gray }, -- |:substitute| replacement text highlighting
    LineNr { fg = Normal.bg, bg = Normal.fg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    MatchParen { fg = Normal.fg, bg = strong_gray }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|

    --
    -- SECTION: Unverified
    --          aka. "I haven't yet assigned these, or don't know what they're for yet"
    --

-- SECTION: Main -------------------------------------------------------------------------
    ColorColumn { fg = Normal.fg, bg = Normal.bg }, -- Columns set with 'colorcolumn' -- highlighted 
    Conceal { fg = Normal.fg, bg = Normal.bg }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor { fg = Normal.fg, bg = Normal.bg }, -- Character under the cursor  -- TODO: this doesn't actually seem to set the cursor color. is that controlled by some other setting?
    lCursor { fg = Normal.fg, bg = Normal.bg }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM { fg = Normal.fg, bg = Normal.bg }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { fg = Normal.fg, bg = Normal.bg }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine { fg = Normal.fg, bg = Normal.bg }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory { fg = Normal.fg, bg = weak_gray }, -- Directory names (and other special names in listings)
    DiffAdd { fg = Normal.fg, bg = Normal.bg }, -- Diff mode: Added line |diff.txt|
    DiffChange { fg = Normal.fg, bg = Normal.bg }, -- Diff mode: Changed line |diff.txt|
    DiffDelete { fg = Normal.fg, bg = Normal.bg }, -- Diff mode: Deleted line |diff.txt|
    DiffText { fg = Normal.fg, bg = Normal.bg }, -- Diff mode: Changed text within a changed line |diff.txt|
    TermCursor { fg = Normal.fg, bg = Normal.bg }, -- Cursor in a focused terminal
    TermCursorNC { fg = Normal.fg, bg = Normal.bg }, -- Cursor in an unfocused terminal
    ErrorMsg { fg = Normal.fg, bg = Normal.bg }, -- Error messages on the command line
    VertSplit { fg = Normal.fg, bg = Normal.bg }, -- Column separating vertically split windows
    Folded { fg = Normal.fg, bg = Normal.bg }, -- Line used for closed folds
    FoldColumn { fg = Normal.fg, bg = Normal.bg }, -- 'foldcolumn'
    SignColumn { fg = Normal.fg, bg = Normal.bg }, -- Column where |signs| are displayed
    LineNrAbove { fg = Normal.fg, bg = Normal.bg }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow { fg = Normal.fg, bg = Normal.bg }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr { fg = Normal.fg, bg = Normal.bg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineFold { fg = Normal.fg, bg = Normal.bg }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    CursorLineSign { fg = Normal.fg, bg = Normal.bg }, -- Like SignColumn when 'cursorline' is set for the cursor line
    ModeMsg { fg = Normal.fg, bg = Normal.bg }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea { fg = Normal.fg, bg = Normal.bg }, -- Area for messages and cmdline
    MsgSeparator { fg = Normal.fg, bg = Normal.bg }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg { fg = Normal.fg, bg = Normal.bg }, -- |more-prompt|
    NonText { fg = Normal.fg, bg = Normal.bg }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    NormalFloat { fg = Normal.fg, bg = Normal.bg }, -- Normal text in floating windows.
    FloatBorder { fg = Normal.fg, bg = Normal.bg }, -- Border of floating windows.
    FloatTitle { fg = Normal.fg, bg = Normal.bg }, -- Title of floating windows.
    NormalNC { fg = Normal.fg, bg = Normal.bg }, -- normal text in non-current windows
    Pmenu { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Normal item.
    PmenuSel { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Selected item.
    PmenuKind { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Normal item "kind"
    PmenuKindSel { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Selected item "kind"
    PmenuExtra { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Normal item "extra text"
    PmenuExtraSel { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Selected item "extra text"
    PmenuSbar { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Scrollbar.
    PmenuThumb { fg = Normal.fg, bg = Normal.bg }, -- Popup menu: Thumb of the scrollbar.
    Question { fg = Normal.fg, bg = Normal.bg }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { fg = Normal.fg, bg = Normal.bg }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey { fg = Normal.fg, bg = Normal.bg }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad { fg = Normal.fg, bg = Normal.bg }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap { fg = Normal.fg, bg = Normal.bg }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal { fg = Normal.fg, bg = Normal.bg }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare { fg = Normal.fg, bg = Normal.bg }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine { fg = Normal.fg, bg = Normal.bg }, -- Status line of current window
    StatusLineNC { fg = Normal.fg, bg = Normal.bg }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine { fg = Normal.fg, bg = Normal.bg }, -- Tab pages line, not active tab page label
    TabLineFill { fg = Normal.fg, bg = Normal.bg }, -- Tab pages line, where there are no labels
    TabLineSel { fg = Normal.fg, bg = Normal.bg }, -- Tab pages line, active tab page label
    Title { fg = Normal.fg, bg = Normal.bg }, -- Titles for output from ":set all", ":autocmd" etc.
    WarningMsg { fg = Normal.fg, bg = Normal.bg }, -- Warning messages
    Whitespace { fg = Normal.fg, bg = Normal.bg }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator { fg = Normal.fg, bg = Normal.bg }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu { fg = Normal.fg, bg = Normal.bg }, -- Current match in 'wildmenu' completion
    WinBar { fg = Normal.fg, bg = Normal.bg }, -- Window bar of current window
    WinBarNC { fg = Normal.fg, bg = Normal.bg }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment { fg = mid_gray, bg = Normal.bg, gui = 'italic' }, -- Any comment
    SpecialComment { fg = Normal.fg, bg = Normal.bg }, --   Special things inside a comment (e.g. '\n')

    Constant { fg = Normal.fg, bg = Normal.bg }, -- (*) Any constant
    String { fg = Normal.fg, bg = Normal.bg }, --   A string constant: "this is a string"
    Character { fg = Normal.fg, bg = Normal.bg }, --   A character constant: 'c', '\n'
    Number { fg = Normal.fg, bg = Normal.bg }, --   A number constant: 234, 0xff
    Boolean { fg = Normal.fg, bg = Normal.bg }, --   A boolean constant: TRUE, false
    Float { fg = Normal.fg, bg = Normal.bg }, --   A floating point constant: 2.3e10

    Identifier { fg = Normal.fg, bg = Normal.bg }, -- (*) Any variable name
    Function { fg = Normal.fg, bg = Normal.bg }, --   Function name (also: methods for classes)

    Statement { fg = Normal.fg, bg = Normal.bg }, -- (*) Any statement
    Conditional { fg = Normal.fg, bg = Normal.bg }, --   if, then, else, endif, switch, etc.
    Repeat { fg = Normal.fg, bg = Normal.bg }, --   for, do, while, etc.
    Label { fg = Normal.fg, bg = Normal.bg }, --   case, default, etc.
    Operator { fg = Normal.fg, bg = Normal.bg }, --   "sizeof", "+", "*", etc.
    Keyword { fg = Normal.fg, bg = Normal.bg }, --   any other keyword
    Exception { fg = Normal.fg, bg = Normal.bg }, --   try, catch, throw

    PreProc { fg = Normal.fg, bg = Normal.bg }, -- (*) Generic Preprocessor
    Include { fg = Normal.fg, bg = Normal.bg }, --   Preprocessor #include
    Define { fg = Normal.fg, bg = Normal.bg }, --   Preprocessor #define
    Macro { fg = Normal.fg, bg = Normal.bg }, --   Same as Define
    PreCondit { fg = Normal.fg, bg = Normal.bg }, --   Preprocessor #if, #else, #endif, etc.

    Type { fg = Normal.fg, bg = Normal.bg }, -- (*) int, long, char, etc.
    StorageClass { fg = Normal.fg, bg = Normal.bg }, --   static, register, volatile, etc.
    Structure { fg = Normal.fg, bg = Normal.bg }, --   struct, union, enum, etc.
    Typedef { fg = Normal.fg, bg = Normal.bg }, --   A typedef

    Special { fg = Normal.fg, bg = Normal.bg }, -- (*) Any special symbol
    SpecialChar { fg = Normal.fg, bg = Normal.bg }, --   Special character in a constant
    Tag { fg = Normal.fg, bg = Normal.bg }, --   You can use CTRL-] on this
    Delimiter { fg = Normal.fg, bg = Normal.bg }, --   Character that needs attention
    Debug { fg = black, bg = debug }, --   Debugging statements

    Underlined { fg = Normal.fg, bg = Normal.bg, gui = 'underlined' }, -- Text that stands out, HTML links
    Ignore { fg = Normal.fg, bg = Normal.bg }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error { fg = Normal.fg, bg = Normal.bg }, -- Any erroneous construct
    Todo { fg = Normal.fg, bg = Normal.bg }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- END: Main -------------------------------------------------------------------------

    -- SECTION: LSP ----------------------------------------------------------------------------
    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!


    LspReferenceText { fg = Normal.fg, bg = Normal.bg }, -- Used for highlighting "text" references
    LspReferenceRead { fg = Normal.fg, bg = Normal.bg }, -- Used for highlighting "read" references
    LspReferenceWrite { fg = Normal.fg, bg = Normal.bg }, -- Used for highlighting "write" references
    LspCodeLens { fg = Normal.fg, bg = Normal.bg }, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    LspCodeLensSeparator { fg = Normal.fg, bg = Normal.bg }, -- Used to color the seperator between two or more code lens.
    LspSignatureActiveParameter { fg = Normal.fg, bg = Normal.bg }, -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- END: LSP ----------------------------------------------------------------------------


    -- SECTION: Diagnostics --------------------------------------------------------------------

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!

    DiagnosticError { fg = Normal.bg, bg = Normal.fg, gui = "strikethrough"  }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn { fg = Normal.fg, bg = Normal.bg, gui = "underdotted" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo { fg = Normal.fg, bg = Normal.bg, gui = "underdotted" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint { fg = Normal.fg, bg = Normal.bg, gui = "underdotted" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk { fg = Normal.fg, bg = Normal.bg, gui = "underdotted" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

    -- INFO: Some unused below:
    -- WARNING: Some of these may be hallucinations.
    DiagnosticVirtualTextError { fg = DiagnosticError.fg, bg = DiagnosticError.bg, gui = DiagnosticError.gui }, -- Used for "Error" diagnostic virtual text.
    DiagnosticUnderlineError { fg = DiagnosticError.fg, bg = DiagnosticError.bg, gui = DiagnosticError.gui }, -- Used for underlined "Error" diagnostics.
    DiagnosticFloatingError { fg = DiagnosticError.fg, bg = DiagnosticError.bg, gui = DiagnosticError.gui }, -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    DiagnosticSignError { fg = DiagnosticError.fg, bg = DiagnosticError.bg, gui = DiagnosticError.gui }, -- Used for "Error" signs in sign column.
    -- WARN:
    DiagnosticVirtualTextWarn { fg = DiagnosticWarn.fg, bg = DiagnosticWarn.bg, gui = DiagnosticWarn.gui }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticUnderlineWarn { fg = DiagnosticWarn.fg, bg = DiagnosticWarn.bg, gui = DiagnosticWarn.gui }, -- Used to underline "Warn" diagnostics.
    DiagnosticFloatingWarn { fg = DiagnosticWarn.fg, bg = DiagnosticWarn.bg, gui = DiagnosticWarn.gui }, -- Used to color "Warn" diagnostic messages in diagnostics float.
    DiagnosticSignWarn { fg = DiagnosticWarn.fg, bg = DiagnosticWarn.bg, gui = DiagnosticWarn.gui }, -- Used for "Warn" signs in sign column.
    -- INFO:
    DiagnosticVirtualTextInfo { fg = DiagnosticInfo.fg, bg = DiagnosticInfo.bg, gui = DiagnosticInfo.gui }, -- Used for "Info" diagnostic virtual text.
    DiagnosticUnderlineInfo { fg = DiagnosticInfo.fg, bg = DiagnosticInfo.bg, gui = DiagnosticInfo.gui }, -- Used to underline "Info" diagnostics.
    DiagnosticFloatingInfo { fg = DiagnosticInfo.fg, bg = DiagnosticInfo.bg, gui = DiagnosticInfo.gui }, -- Used to color "Info" diagnostic messages in diagnostics float.
    DiagnosticSignInfo { fg = DiagnosticInfo.fg, bg = DiagnosticInfo.bg, gui = DiagnosticInfo.gui }, -- Used for "Info" signs in sign column.
    -- HINT:
    DiagnosticVirtualTextHint { fg = DiagnosticHint.fg, bg = DiagnosticHint.bg, gui = DiagnosticHint.gui }, -- Used for "Hint" diagnostic virtual text.
    DiagnosticUnderlineHint { fg = Normal.fg, bg = Normal.bg }, -- Used to underline "Hint" diagnostics.
    DiagnosticFloatingHint { fg = Normal.fg, bg = Normal.bg }, -- Used to color "Hint" diagnostic messages in diagnostics float.
    DiagnosticSignHint { fg = Normal.fg, bg = Normal.bg }, -- Used for "Hint" signs in sign column.
    -- OK:
    DiagnosticVirtualTextOk { fg = Normal.fg, bg = Normal.bg }, -- Used for "Ok" diagnostic virtual text.
    DiagnosticUnderlineOk { fg = Normal.fg, bg = Normal.bg }, -- Used to underline "Ok" diagnostics.
    DiagnosticFloatingOk { fg = Normal.fg, bg = Normal.bg }, -- Used to color "Ok" diagnostic messages in diagnostics float.
    DiagnosticSignOk { fg = Normal.fg, bg = Normal.bg }, -- Used for "Ok" signs in sign column.

-- END: Diagnostics




-- SECTION: Tree-Sitter

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    sym"@text.literal" { fg = Normal.fg, bg = Comment.bg, gui = Comment.gui }, -- Comment
    sym"@comment" { fg = Normal.fg, bg = Comment.bg }, -- Comment
    -- sym"@text.reference" { fg = Normal.fg, bg = Normal.bg, gui = Underlined.gui }, -- Identifier
    -- sym"@text.title" { fg = Normal.fg, bg = Normal.bg }, -- Title
    -- sym"@text.uri" { fg = Normal.fg, bg = Normal.bg }, -- Underlined
    -- sym"@text.underline" { fg = Normal.fg, bg = Normal.bg }, -- Underlined
    -- sym"@text.todo" { fg = Normal.fg, bg = Normal.bg }, -- Todo
    -- sym"@punctuation" { fg = Normal.fg, bg = Normal.bg }, -- Delimiter
    -- sym"@constant" { fg = Normal.fg, bg = Normal.bg }, -- Constant
    -- sym"@constant.builtin" { fg = Normal.fg, bg = Normal.bg }, -- Special
    -- sym"@constant.macro" { fg = Normal.fg, bg = Normal.bg }, -- Define
    -- sym"@define" { fg = Normal.fg, bg = Normal.bg }, -- Define
    -- sym"@macro" { fg = Normal.fg, bg = Normal.bg }, -- Macro
    -- sym"@string" { fg = Normal.fg, bg = Normal.bg }, -- String
    -- sym"@string.escape" { fg = Normal.fg, bg = Normal.bg }, -- SpecialChar
    -- sym"@string.special" { fg = Normal.fg, bg = Normal.bg }, -- SpecialChar
    -- sym"@character" { fg = Normal.fg, bg = Normal.bg }, -- Character
    -- sym"@character.special" { fg = Normal.fg, bg = Normal.bg }, -- SpecialChar
    -- sym"@number" { fg = Normal.fg, bg = Normal.bg }, -- Number
    -- sym"@boolean" { fg = Normal.fg, bg = Normal.bg }, -- Boolean
    -- sym"@float" { fg = Normal.fg, bg = Normal.bg }, -- Float
    -- sym"@function" { fg = Normal.fg, bg = Normal.bg }, -- Function
    -- sym"@function.builtin" { fg = Normal.fg, bg = Normal.bg }, -- Special
    -- sym"@function.macro" { fg = Normal.fg, bg = Normal.bg }, -- Macro
    -- sym"@parameter" { fg = Normal.fg, bg = Normal.bg }, -- Identifier
    -- sym"@method" { fg = Normal.fg, bg = Normal.bg }, -- Function
    -- sym"@field" { fg = Normal.fg, bg = Normal.bg }, -- Identifier
    -- sym"@property" { fg = Normal.fg, bg = Normal.bg }, -- Identifier
    -- sym"@constructor" { fg = Normal.fg, bg = Normal.bg }, -- Special
    -- sym"@conditional" { fg = Normal.fg, bg = Normal.bg }, -- Conditional
    -- sym"@repeat" { fg = Normal.fg, bg = Normal.bg }, -- Repeat
    -- sym"@label" { fg = Normal.fg, bg = Normal.bg }, -- Label
    -- sym"@operator" { fg = Normal.fg, bg = Normal.bg }, -- Operator
    -- sym"@keyword" { fg = Normal.fg, bg = Normal.bg }, -- Keyword
    -- sym"@exception" { fg = Normal.fg, bg = Normal.bg }, -- Exception
    -- sym"@variable" { fg = Normal.fg, bg = Normal.bg }, -- Identifier
    -- sym"@type" { fg = Normal.fg, bg = Normal.bg }, -- Type
    -- sym"@type.definition" { fg = Normal.fg, bg = Normal.bg }, -- Typedef
    -- sym"@storageclass" { fg = Normal.fg, bg = Normal.bg }, -- StorageClass
    -- sym"@structure" { fg = Normal.fg, bg = Normal.bg }, -- Structure
    -- sym"@namespace" { fg = Normal.fg, bg = Normal.bg }, -- Identifier
    -- sym"@include" { fg = Normal.fg, bg = Normal.bg }, -- Include
    -- sym"@preproc" { fg = Normal.fg, bg = Normal.bg }, -- PreProc
    -- sym"@debug" { fg = Normal.fg, bg = Normal.bg }, -- Debug
    -- sym"@tag" { fg = Normal.fg, bg = Normal.bg }, -- Tag

    -- END: Tree-Sitter

    -- SECTION: Telescope
    -- NOTE: UNUSED

    -- Additional Plugin & LSP Groups from PLAN.md
    -- TelescopeNormal { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeSelection { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeSelectionCaret { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeMultiSelection { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeMatching { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeBorder { fg = Normal.fg, bg = Normal.bg },
    -- TelescopePromptBorder { fg = Normal.fg, bg = Normal.bg },
    -- TelescopePromptNormal { fg = Normal.fg, bg = Normal.bg },
    -- TelescopePromptTitle { fg = Normal.fg, bg = Normal.bg },
    -- TelescopePreviewTitle { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeResultsTitle { fg = Normal.fg, bg = Normal.bg },
    -- TelescopeResultsNormal { fg = Normal.fg, bg = Normal.bg },

    -- END: Telescope

    -- SECTION: Which-Key
    -- NOTE: UNUSED

    -- WhichKey { fg = Normal.fg, bg = Normal.bg },
    -- WhichKeyGroup { fg = Normal.fg, bg = Normal.bg },
    -- WhichKeySeparator { fg = Normal.fg, bg = Normal.bg },
    -- WhichKeyDesc { fg = Normal.fg, bg = Normal.bg },
    -- WhichKeyFloat { fg = Normal.fg, bg = Normal.bg },
    -- WhichKeyBorder { fg = Normal.fg, bg = Normal.bg },
    -- WhichKeyTitle { fg = Normal.fg, bg = Normal.bg },

    -- END: Which-Key

    -- SECTION: Which-Key
    -- NOTE: UNUSED

    -- TroubleText { fg = Normal.fg, bg = Normal.bg },
    -- TroubleCount { fg = Normal.fg, bg = Normal.bg },
    -- TroubleNormal { fg = Normal.fg, bg = Normal.bg },
    -- TroubleIndent { fg = Normal.fg, bg = Normal.bg },
    -- TroubleIndentWrap { fg = Normal.fg, bg = Normal.bg },
    -- TroubleLocation { fg = Normal.fg, bg = Normal.bg },
    -- TroublePreview { fg = Normal.fg, bg = Normal.bg },
    -- TroubleSign { fg = Normal.fg, bg = Normal.bg },

    -- END: Which-Key

    -- SECTION: GitSigns
    -- NOTE: UNUSED

    -- GitSignsAdd { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsChange { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsDelete { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsAddLn { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsChangeLn { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsDeleteLn { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsAddNr { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsChangeNr { fg = Normal.fg, bg = Normal.bg },
    -- GitSignsDeleteNr { fg = Normal.fg, bg = Normal.bg },

    -- END: GitSigns

    -- SECTION: Misc
    -- NOTE: UNUSED

    -- FlashBackdrop { fg = Normal.fg, bg = Normal.bg },
    -- FlashLabel { fg = Normal.fg, bg = Normal.bg },
    -- FlashMatch { fg = Normal.fg, bg = Normal.bg },
    -- IblIndent { fg = Normal.fg, bg = Normal.bg },
    -- IblScope { fg = Normal.fg, bg = Normal.bg },
    -- IblWhitespace { fg = Normal.fg, bg = Normal.bg },
    -- NotifyERRORBorder { fg = Normal.fg, bg = Normal.bg },
    -- NotifyWARNBorder { fg = Normal.fg, bg = Normal.bg },
    -- NotifyINFOBorder { fg = Normal.fg, bg = Normal.bg },
    -- NotifyDEBUGBorder { fg = Normal.fg, bg = Normal.bg },
    -- NotifyTRACEBorder { fg = Normal.fg, bg = Normal.bg },
    -- NotifyERRORBody { fg = Normal.fg, bg = Normal.bg },
    -- NotifyWARNBody { fg = Normal.fg, bg = Normal.bg },
    -- NotifyINFOBody { fg = Normal.fg, bg = Normal.bg },
    -- NotifyDEBUGBody { fg = Normal.fg, bg = Normal.bg },
    -- NotifyTRACEBody { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.class" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.comment" { fg = Comment.fg, bg = Comment.bg, gui = Comment.gui },
    -- sym"@lsp.type.decorator" { fg = Normal.fg, bg = Normal.bg, gui = Comment.gui },
    -- sym"@lsp.type.enum" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.enumMember" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.function" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.interface" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.keyword" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.namespace" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.parameter" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.property" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.struct" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.type" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.typeParameter" { fg = Normal.fg, bg = Normal.bg },
    -- sym"@lsp.type.variable" { fg = Normal.fg, bg = Normal.bg },

    -- END: Misc
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
