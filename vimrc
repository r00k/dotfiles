call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'fxn/vim-monochrome'
Plug 'w0rp/ale'
Plug 'ngmy/vim-rubocop'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-rails'

call plug#end()

" Emojis ALE
let g:ale_sign_error = '🙊'
let g:ale_sign_warning = '🙈'

" enable setting title
set title
set wildignore=.o,.obj,.git,Godeps/**,node_modules/**,tmp/**

set cc=80   " Highlight column 80
set number  " show number lines
set mouse=a " use the mouse luke
let mapleader = ","
let g:mapleader = "," " New Leader

" Indentation
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType * set ai sw=2 sts=2 et
  autocmd BufRead,BufNewFile *_test.rb let b:dispatch = 'bundle exec ruby -Itest %'
  autocmd BufRead,BufNewFile *_spec.rb let b:dispatch = 'bundle exec rspec %'
augroup END

" Aliases
map <leader>f :FZF<CR>
let g:rspec_command = "Dispatch bundle exec rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>r :call Rubocop()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" Remap save caps to uncaps
command! Q q " Bind :Q to :q
command! E e
command! W w
command! Wq wq

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

" Move stuff with arrows
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

" Go to previous file
nnoremap <leader><leader> <c-^>

" Tab completion
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
