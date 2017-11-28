execute pathogen#infect()
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

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  " autocmd FileType ruby let b:dispatch = 'bundle exec testrb %'
  autocmd BufRead,BufNewFile *_test.rb let b:dispatch = 'bundle exec ruby -Itest %'
  autocmd BufRead,BufNewFile *_spec.rb let b:dispatch = 'bundle exec rspec %'

  autocmd FileType elixir set ai sw=2 sts=2 et
  " autocmd FileType ruby let b:dispatch = 'bundle exec testrb %'
  autocmd BufRead,BufNewFile *_test.exs let b:dispatch = 'mix test %'

  " Javascript
  autocmd FileType javascript set sw=2
  autocmd FileType javascript set ts=2
  autocmd FileType javascript set sts=2
  autocmd FileType javascript set expandtab
  autocmd FileType javascript set textwidth=79

  " CSS
  autocmd FileType javascript set sw=2
  autocmd FileType javascript set ts=2
  autocmd FileType javascript set sts=2
  autocmd FileType javascript set expandtab
  autocmd FileType javascript set textwidth=79

  " Golang
  autocmd FileType go set ai sw=4 sts=4 et
  au FileType go nmap <C-i> <Plug>(go-info)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
  au FileType go nmap <leader>gr <Plug>(go-run)
  au FileType go nmap <leader>gb <Plug>(go-build)
  au FileType go nmap <leader>gt <Plug>(go-test)
  au FileType go nmap <leader>gc <Plug>(go-coverage)
  au FileType go nmap <leader>gdd <Plug>(go-def)
augroup END

" Aliases
map <leader>f :FuzzyOpen<CR>
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

map <C-h> :nohl<cr>
imap <C-l> :<Space>
" Note that remapping C-s requires flow control to be disabled
" (e.g. in .bashrc or .zshrc)
map <C-s> <esc>:w<CR>
map <D-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
imap <D-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>
map <C-v> <esc>:vsplit<CR>
map <C-x> <C-w>c

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

" jj to escape
inoremap jj <ESC>

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
