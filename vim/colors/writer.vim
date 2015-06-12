" Name:     Writer Colorscheme for Vim
" Author:   Nathan Long <nathan@nathan-long.com>
" License:  Do whatever you feel like with this thing
"
" About:    I based this off of the methods used in Ethan Schoonover's
"           Solarized theme (http://ethanschoonover.com/solarized), as in
"           almost verbatim... but in a much simpler format. I use this theme
"           for when I use vim to write.
"
"           This also utilizes Solarized background swap plugin.
"
" ---------------------------------------------------------------------
" Colorscheme initialization
" ---------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "writer"

" COLOR VALUES
"
" base1    = background
" base2    = low contrast background
" text     = normal text color
" textlo   = low contrast text
" texthi   = high contrast text
" altlo    = low contrast alt
" althi    = high contrast alt
" accentlo = lo contrast accent
" accenthi = high contrast accent
" nearinv  = nearly invisible (but not quite)

" Color variables
" ---------------------------------------------------------------------
let s:base1            = "#111111"
let s:base2            = "#091f0f"
let s:text             = "#216e35"
let s:textlo           = "#13401f"
let s:texthi           = "#428f55"
let s:altlo            = "#00503c"
let s:althi            = "#007a5a"
let s:accentlo         = "#235257"
let s:accenthi         = "#307278"
let s:nearinv          = "#111811"

" Formatting options and null values for passthrough effect
" ---------------------------------------------------------------------
let s:none            = "NONE"
let s:n               = "NONE"
let s:c               = ",undercurl"
let s:r               = ",reverse"
let s:s               = ",standout"
let s:ou              = ""
let s:ob              = ""
let s:b               = ",bold"
let s:u               = ",underline"
let s:i               = ",italic"
let s:back            = s:base1
let s:vmode           = "gui"

" Light Scheme
" ---------------------------------------------------------------------
if &background == "light"
  let s:base1         = "#ebebeb"
  let s:base2         = "#d4d5d9"
  let s:text          = "#555555"
  let s:textlo        = "#a6a6a6"
  let s:texthi        = "#2b2b2b"
  let s:altlo         = "#80d7ff"
  let s:althi         = "#00aeff"
  let s:accentlo      = "#e8c24c"
  let s:accenthi      = "#ab8f38"
  let s:nearinv       = "#e0e0e0"
  if (s:back != "NONE")
    let s:back        = s:base1
  endif
endif

" Highlighting primitives"{{{
" ---------------------------------------------------------------------
exe "let s:bg_none      = ' ".s:vmode."bg=".s:none   ."'"
exe "let s:bg_back      = ' ".s:vmode."bg=".s:back   ."'"
exe "let s:bg_base1     = ' ".s:vmode."bg=".s:base1  ."'"
exe "let s:bg_base2     = ' ".s:vmode."bg=".s:base2  ."'"
exe "let s:bg_text      = ' ".s:vmode."bg=".s:text  ."'"
exe "let s:bg_textlo    = ' ".s:vmode."bg=".s:textlo  ."'"
exe "let s:bg_texthi    = ' ".s:vmode."bg=".s:texthi  ."'"
exe "let s:bg_altlo     = ' ".s:vmode."bg=".s:altlo   ."'"
exe "let s:bg_althi     = ' ".s:vmode."bg=".s:althi   ."'"
exe "let s:bg_accentlo  = ' ".s:vmode."bg=".s:accentlo."'"
exe "let s:bg_accentlo  = ' ".s:vmode."bg=".s:accentlo."'"
exe "let s:bg_nearinv   = ' ".s:vmode."bg=".s:nearinv."'"

exe "let s:fg_none      = ' ".s:vmode."fg=".s:none   ."'"
exe "let s:fg_back      = ' ".s:vmode."fg=".s:back   ."'"
exe "let s:fg_base1     = ' ".s:vmode."fg=".s:base1  ."'"
exe "let s:fg_base2     = ' ".s:vmode."fg=".s:base2  ."'"
exe "let s:fg_text      = ' ".s:vmode."fg=".s:text  ."'"
exe "let s:fg_textlo    = ' ".s:vmode."fg=".s:textlo  ."'"
exe "let s:fg_texthi    = ' ".s:vmode."fg=".s:texthi  ."'"
exe "let s:fg_altlo     = ' ".s:vmode."fg=".s:altlo   ."'"
exe "let s:fg_althi     = ' ".s:vmode."fg=".s:althi   ."'"
exe "let s:fg_accentlo  = ' ".s:vmode."fg=".s:accentlo."'"
exe "let s:fg_accenthi  = ' ".s:vmode."fg=".s:accenthi."'"
exe "let s:fg_nearinv   = '  ".s:vmode."fg=".s:nearinv."'"

exe "let s:fmt_none     = ' ".s:vmode."=NONE".          " term=NONE".    "'"
exe "let s:fmt_bold     = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b."'"
exe "let s:fmt_bldi     = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b."'"
exe "let s:fmt_undr     = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u."'"
exe "let s:fmt_undb     = ' ".s:vmode."=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi     = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u."'"
exe "let s:fmt_uopt     = ' ".s:vmode."=NONE".s:ou.     " term=NONE".s:ou."'"
exe "let s:fmt_curl     = ' ".s:vmode."=NONE".s:c.      " term=NONE".s:c.   " guisp="s:accentlo. "'"
exe "let s:fmt_ital     = ' ".s:vmode."=NONE".s:i.      " term=NONE".s:i."'"
exe "let s:fmt_stnd     = ' ".s:vmode."=NONE".s:s.      " term=NONE".s:s."'"
exe "let s:fmt_revr     = ' ".s:vmode."=NONE".s:r.      " term=NONE".s:r."'"
exe "let s:fmt_revb     = ' ".s:vmode."=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"

" Basic highlighting"{{{
" ---------------------------------------------------------------------

exe "hi! Normal"          .s:fmt_none   .s:fg_text     .s:bg_back
exe "hi! Comment"         .s:fmt_ital   .s:fg_textlo   .s:bg_none
exe "hi! Constant"        .s:fmt_none   .s:fg_texthi   .s:bg_none
exe "hi! Identifier"      .s:fmt_none   .s:fg_altlo    .s:bg_none
exe "hi! Statement"       .s:fmt_none   .s:fg_althi    .s:bg_none
exe "hi! Preproc"         .s:fmt_none   .s:fg_althi    .s:bg_none
exe "hi! Delimiter"       .s:fmt_none   .s:fg_althi    .s:bg_none
exe "hi! Type"            .s:fmt_none   .s:fg_textlo   .s:bg_none
exe "hi! Special"         .s:fmt_none   .s:fg_texthi   .s:bg_none
exe "hi! Underlined"      .s:fmt_none   .s:fg_texthi   .s:bg_none
exe "hi! Ignore"          .s:fmt_none   .s:fg_none     .s:bg_none
exe "hi! Error"           .s:fmt_bold   .s:fg_accenthi .s:bg_none
exe "hi! Todo"            .s:fmt_bold   .s:fg_accenthi .s:bg_none

exe "hi! SpecialKey"      .s:fmt_revr   .s:fg_texthi    .s:bg_none
exe "hi! NonText"         .s:fmt_none   .s:fg_base1     .s:bg_none
exe "hi! StatusLine"      .s:fmt_none   .s:fg_textlo    .s:bg_nearinv
exe "hi! StatusLineNC"    .s:fmt_none   .s:fg_base1     .s:bg_textlo
exe "hi! Visual"          .s:fmt_none   .s:fg_texthi    .s:bg_altlo
exe "hi! Directory"       .s:fmt_none   .s:fg_althi     .s:bg_none
exe "hi! ErrorMsg"        .s:fmt_revr   .s:fg_texthi    .s:bg_none
exe "hi! IncSearch"       .s:fmt_stnd   .s:fg_accenthi  .s:bg_none
exe "hi! Search"          .s:fmt_revr   .s:fg_accenthi  .s:bg_none
exe "hi! MoreMsg"         .s:fmt_none   .s:fg_accenthi  .s:bg_none
exe "hi! ModeMsg"         .s:fmt_none   .s:fg_textlo    .s:bg_none
exe "hi! LineNr"          .s:fmt_none   .s:fg_nearinv    .s:bg_base1
exe "hi! CursorLineNr"    .s:fmt_none   .s:fg_nearinv    .s:bg_base1
exe "hi! Question"        .s:fmt_bold   .s:fg_accentlo  .s:bg_none
exe "hi! VertSplit"       .s:fmt_none   .s:fg_base2     .s:bg_base2
exe "hi! Title"           .s:fmt_bold   .s:fg_accenthi  .s:bg_none
exe "hi! VisualNOS"       .s:fmt_stnd   .s:fg_none      .s:bg_base2
exe "hi! WarningMsg"      .s:fmt_bold   .s:fg_accenthi  .s:bg_none
exe "hi! WildMenu"        .s:fmt_none   .s:fg_text      .s:bg_base2   .s:fmt_revb
exe "hi! Folded"          .s:fmt_undb   .s:fg_base1     .s:bg_base2
exe "hi! FoldColumn"      .s:fmt_none   .s:fg_base1     .s:bg_base2
exe "hi! DiffAdd"         .s:fmt_revr   .s:fg_althi     .s:bg_none
exe "hi! DiffChange"      .s:fmt_revr   .s:fg_accenthi  .s:bg_none
exe "hi! DiffDelete"      .s:fmt_revr   .s:fg_altlo     .s:bg_none
exe "hi! DiffText"        .s:fmt_revr   .s:fg_accentlo  .s:bg_none
exe "hi! SignColumn"      .s:fmt_none   .s:fg_base1
exe "hi! Conceal"         .s:fmt_none   .s:fg_accentlo  .s:bg_none
exe "hi! SpellBad"        .s:fmt_curl   .s:fg_none      .s:bg_none
exe "hi! SpellCap"        .s:fmt_curl   .s:fg_none      .s:bg_none
exe "hi! SpellRare"       .s:fmt_curl   .s:fg_none      .s:bg_none
exe "hi! SpellLocal"      .s:fmt_curl   .s:fg_none      .s:bg_none
exe "hi! Pmenu"           .s:fmt_none   .s:fg_base1     .s:bg_base2   .s:fmt_revb
exe "hi! PmenuSel"        .s:fmt_none   .s:fg_base1     .s:bg_base2   .s:fmt_revb
exe "hi! PmenuSbar"       .s:fmt_none   .s:fg_base2     .s:bg_base1   .s:fmt_revb
exe "hi! PmenuThumb"      .s:fmt_none   .s:fg_base1     .s:bg_textlo  .s:fmt_revb
exe "hi! TabLine"         .s:fmt_undr   .s:fg_base1     .s:bg_base2
exe "hi! TabLineFill"     .s:fmt_undr   .s:fg_base1     .s:bg_base2
exe "hi! TabLineSel"      .s:fmt_undr   .s:fg_base1     .s:bg_base2
exe "hi! CursorColumn"    .s:fmt_none   .s:fg_none      .s:bg_base2
exe "hi! CursorLine"      .s:fmt_uopt   .s:fg_none      .s:bg_nearinv
exe "hi! ColorColumn"     .s:fmt_none   .s:fg_none      .s:bg_nearinv
exe "hi! Cursor"          .s:fmt_none   .s:fg_base2     .s:bg_althi

" html highlighting
" ---------------------------------------------------------------------

exe "hi! htmlTag"           .s:fmt_none .s:fg_base2    .s:bg_none
exe "hi! htmlEndTag"        .s:fmt_none .s:fg_base2    .s:bg_none
exe "hi! htmlTagN"          .s:fmt_bold .s:fg_base2    .s:bg_none
exe "hi! htmlTagName"       .s:fmt_bold .s:fg_althi    .s:bg_none
exe "hi! htmlSpecialTagName".s:fmt_ital .s:fg_althi    .s:bg_none
exe "hi! htmlArg"           .s:fmt_none .s:fg_texthi   .s:bg_none
exe "hi! javaScript"        .s:fmt_none .s:fg_accenthi .s:bg_none

" Markdown
" ---------------------------------------------------------------------

exe "hi! htmlH1"                        .s:fmt_bold    .s:fg_text     .s:bg_none
exe "hi! htmlH2"                        .s:fmt_bold    .s:fg_text     .s:bg_none
exe "hi! htmlH3"                        .s:fmt_bold    .s:fg_text     .s:bg_none
exe "hi! htmlH4"                        .s:fmt_bold    .s:fg_text     .s:bg_none
exe "hi! markdownListMarker"            .s:fmt_none    .s:fg_althi    .s:bg_none
exe "hi! htmlString"                    .s:fmt_bold    .s:fg_accenthi .s:bg_none
exe "hi! htmlItalic"                    .s:fmt_ital    .s:fg_text     .s:bg_none
exe "hi! htmlBold"                      .s:fmt_bold    .s:fg_text     .s:bg_none
exe "hi! markdownUrl"                   .s:fmt_none    .s:fg_althi    .s:bg_none
exe "hi! markdownUrlTitle"              .s:fmt_none    .s:fg_accenthi .s:bg_none
exe "hi! markdownLinkText"              .s:fmt_ital    .s:fg_accenthi .s:bg_none
exe "hi! markdownStyleDelimiter"        .s:fmt_none    .s:fg_textlo    .s:bg_none
