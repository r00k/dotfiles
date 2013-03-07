" Use Pathogen:
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ========================================================================
" Vundle stuff
" ========================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" My bundles
Bundle 'ervandew/supertab'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'tangledhelix/vim-octopress.git'
Bundle 'godlygeek/tabular'
Bundle 'nono/vim-handlebars'
Bundle 'tpope/vim-haml'
Bundle 'bbommarito/vim-slim'
Bundle 'skwp/vim-rspec'
Bundle 'mattn/gist-vim'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-endwise'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Raimondi/delimitMate'
Bundle 'corntrace/bufexplorer'
Bundle 'tpope/vim-rbenv'
Bundle 'rodjek/vim-puppet'

" ================
" Ruby stuff
" ================
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  "octopress
  autocmd BufNewFile,BufRead *.markdown,*.textile set filetype=octopress
augroup END
" ================
" NERDTREE STUFF
"
"let g:nerdtree_tabs_open_on_gui_startup = 1
"let g:nerdtree_tabs_smart_startup_focus = 1
"let g:nerdtree_tabs_open_on_new_tab = 1
"let g:nerdtree_tabs_focus_on_files = 1


let mapleader = ","
let g:mapleader = ","

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
nmap <Leader>bi :source ~/.vimrc<cr>:BundleInstall<cr>
vmap <Leader>bed "td?describe<cr>obed<tab><esc>"tpkdd/end<cr>o<esc>:nohl<cr>
map <Leader>cc :!cucumber --drb %<CR>
map <Leader>cu :Tabularize /\|<CR>
map <Leader>co ggVG"*y
" map <Leader>cc :Rjcollection client/
map <Leader>a :A<CR>
map <Leader>cj :Rjspec client/
map <Leader>cm :Rjmodel client/
map <Leader>ct :Rtemplate client/
map <Leader>cv :Rjview client/
map <Leader>cm :Rjmodel client/
map <Leader>d odebugger<cr>puts 'debugger'<esc>:w<cr>
map <Leader>dr :e ~/Dropbox<cr>
map <Leader>ec :e ~/code/
map <Leader>gac :Gcommit -m -a ""<LEFT>
map <leader>g :CtrlP<CR>
map <leader>gv :CtrlP app/views/<CR>
map <leader>gc :CtrlP app/controllers/<CR>
map <leader>gm :CtrlP app/models/<CR>
map <Leader>f :call OpenFactoryFile()<CR>
map <Leader>fix :cnoremap % %<CR>
map <Leader>fa :sp test/factories.rb<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>l oconsole.log 'debugging'<esc>:w<cr>
map <Leader>m :Rmodel
""Quick vim regex to convert hashrocket (=>) 1.8 to colon syntax (:) 1.9:
nmap <leader>nh :%s/\v:(\w+) \=\>/\1:/g<cr>
map <Leader>o :call RunCurrentLineInTest()<CR>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map <Leader>ra :%s/
map <Leader>rd :!bundle exec rspec % --format documentation<CR>
map <Leader>rf :CommandTFlush<CR>
map <Leader>rt q:?!ruby<cr><cr>
map <Leader>rw :%s/\s\+$//<cr>:w<cr>
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>sg :sp<cr>:grep
map <Leader>sm :RSmodel
map <Leader>sp yss<p>
map <Leader>snip :e ~/.vim/snippets/ruby.snippets<CR>
map <Leader>so :so %<cr>
map <Leader>sq j<c-v>}klllcs<esc>:wq<cr>
map <Leader>ss ds)i <esc>:w<cr>
map <Leader>st :!ruby -Itest % -n "//"<left><left>
map <Leader>su :RSunittest
map <Leader>sv :RSview
map <Leader>t :call RunCurrentTest()<CR>
map <Leader>y :!rspec --drb %<cr>
map <Leader>u :Runittest<cr>
map <Leader>vc :RVcontroller<cr>
map <Leader>vf :RVfunctional<cr>
map <Leader>vg :vsp<cr>:grep
map <Leader>vi :tabe ~/.vimrc<CR>
map <Leader>vu :RVunittest<CR>
map <Leader>vm :RVmodel<cr>
map <Leader>vv :RVview<cr>
map <Leader>w <C-w>w
map <Leader>x :exec getline(".")<cr>
map <Leader>z :NERDTreeToggle<cr>
nnoremap <leader><leader> <c-^>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

map <C-h> :nohl<cr>
imap <C-l> :<Space>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>
map <C-x> <C-w>c
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Get off my lawn
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoindent
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=Triskweline_10:h10
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set number
"set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light
set shell=zsh
set shellcmdflag=-ci
set colorcolumn=120
set guifont=Bitstream\ Vera\ Sans\ Mono:h12
let g:NERDTreeWinPos = "right"
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set showbreak=↪

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

set mouse=nicr

" Set the tag file search order
set tags=./tags;

" Use _ as a word-separator
" set iskeyword-=_

" Use Ack instead of grep
set grepprg=ack

" Get rid of the delay when hitting esc!
set noesckeys

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"
" Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Say no to code folding...

command! Q q " Bind :Q to :q
command! Qall qall


" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" When loading text files, wrap them and don't split up words.
au BufNewFile,BufRead *.txt setlocal wrap
au BufNewFile,BufRead *.txt setlocal lbr

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

" Merge a tab into a split in the previous window
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

nmap <C-W>u :call MergeTabs()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <Tab> <C-P>

" Let's be reasonable, shall we?
nmap k gk
nmap j gj


" Set up some useful Rails.vim bindings for working with Backbone.js
autocmd User Rails Rnavcommand template    app/assets/templates               -glob=**/*  -suffix=.jst.ejs
autocmd User Rails Rnavcommand jmodel      app/assets/javascripts/models      -glob=**/*  -suffix=.coffee
autocmd User Rails Rnavcommand jview       app/assets/javascripts/views       -glob=**/*  -suffix=.coffee
autocmd User Rails Rnavcommand jcollection app/assets/javascripts/collections -glob=**/*  -suffix=.coffee
autocmd User Rails Rnavcommand jrouter     app/assets/javascripts/routers     -glob=**/*  -suffix=.coffee
autocmd User Rails Rnavcommand jspec       spec/javascripts                   -glob=**/*  -suffix=.coffee

" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or

" set statusline+=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let g:CommandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" Don't go past 100 chars on levelup:
autocmd BufNewFile,BufRead /Users/ben/code/levelup/*.rb set colorcolumn=100

" Remove trailing whitespace on save for ruby files.
au BufWritePre *.rb :%s/\s\+$//e

function! OpenFactoryFile()
  if filereadable("test/factories.rb")
    execute ":sp test/factories.rb"
  else
    execute ":sp spec/factories.rb"
  end
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" ========================================================================
" End of things set by me.
" ========================================================================

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
:set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"show trailing spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

color codeschool
