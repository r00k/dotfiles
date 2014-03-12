" Begin .vimrc
"
set nocompatible " default to vim
"
" ================
" Ruby stuff
" ================
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles " load bundles from another file
endif

syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  autocmd FileType go set ai sw=4 sts=4 et
  au FileType go au BufWritePre <buffer> Fmt
augroup END


let mapleader = ","
let g:mapleader = ","

nmap <Leader>bi :source ~/.vimrc<cr>:BundleInstall<cr>
map <Leader>co ggVG"*y
map <Leader>a :A<CR>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets/sass<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>
map <leader>i mmgg=G`m<CR>
""Quick vim regex to convert hashrocket (=>) 1.8 to colon syntax (:) 1.9:
nmap <leader>nh :%s/\v:(\w+) \=\>/\1:/g<cr>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
map <Leader>w <C-w>w
map <Leader>x :exec getline(".")<cr>
nnoremap <leader><leader> <c-^>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

nmap <C-)> <C-]>
inoremap jj <ESC>

" Get off my lawn
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		       " keep 500 lines of command line history
set ruler		       " show the cursor position all the time
set showcmd		       " display incomplete commands
set autoindent                 " auto ident relative to last line
set showmatch                  " show matching char like () []
set relativenumber             "set relative line numbers
set nowrap                     " do not wrap text
set backupdir=~/.vim_backup/   " where to put backup files.
set directory=~/.vim_temp/     " where to put swap files.
set autoread                   " Auto read file changes
set viminfo+=!
set guioptions-=T              " Do not include toolbar in GUI
set guioptions-=r              " Removes right hand scroll bar
set guioptions-=L              " Removes left hand scroll bar
set expandtab                  " Expand tabs in spaces
set shiftwidth=2               " Number of spaces for a tab
set smarttab                   " something about tabs... see help
set noincsearch                " Do not search immediately
set ignorecase smartcase
set laststatus=2               " Always show status line.
set colorcolumn=80             " If more than 80 chars... show a line >>>>>>>>>
set guifont=Bitstream\ Vera\ Sans\ Mono:h14
set showbreak=↪
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set mouse=a      " Mouse in all modes
set tags=./tags; " Set the tag file search order

set grepprg=ag " Use ag instead of grep
let g:ackprg = 'ag --nogroup --nocolor --column' " Ag instead of Ack


" Vim rspec dispatch
let g:rspec_command = "!bin/rspec {spec}"
" Gist options
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

command! Q q " Bind :Q to :q
command! Qall qall

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" When loading text files, wrap them and don't split up words.
au BufNewFile,BufRead *.txt setlocal wrap
au BufNewFile,BufRead *.txt setlocal lbr

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Let's be reasonable, shall we?
nmap k gk
nmap j gj


let g:CommandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" Remove trailing whitespace on save for ruby files.
"au BufWritePre *.rb :%s/\s\+$//e

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>pl :PromoteToLet<cr>

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

  set background=dark
  color solarized
  "colorscheme monochrome

" Highlight words to avoid in tech writing
" =======================================
"
"   obviously, basically, simply, of course, clearly,
"   just, everyone knows, However, So, easy

"   http://css-tricks.com/words-avoid-educational-writing/

highlight TechWordsToAvoid ctermbg=red ctermfg=white
function MatchTechWordsToAvoid()
        match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfunction
autocmd FileType markdown call MatchTechWordsToAvoid()
autocmd BufWinEnter *.md call MatchTechWordsToAvoid()
autocmd InsertEnter *.md call MatchTechWordsToAvoid()
autocmd InsertLeave *.md call MatchTechWordsToAvoid()
autocmd BufWinLeave *.md call clearmatches()
