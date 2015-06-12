execute pathogen#infect()
" Theme and stuff
colorscheme monochrome
" colorscheme base16-grayscale
if has("gui_macvim")
  map <leader>ia :source ~/.vim/writer.vim
  autocmd vimenter * source ~/.vim/writer.vim
else
  set background=dark
end


set cc=80   " Highlight column 80
set number  " show number lines
set mouse=a " use the mouse luke
" New Leader
let mapleader = ","
let g:mapleader = ","

" Enable spellchecking for Markdown
" autocmd FileType markdown setlocal spell

" Automatically wrap at 80 characters for Markdown
" autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Indentation
" Softtabs, 2 spaces
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
	autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
	autocmd FileType ruby let b:dispatch = 'bundle exec testrb %'

	" Javascript
	autocmd FileType javascript set sw=2
	autocmd FileType javascript set ts=2
	autocmd FileType javascript set sts=2
	autocmd FileType javascript set expandtab
	autocmd FileType javascript set textwidth=79

	" CoffeeScript
	autocmd FileType CoffeeScript,*.coffee set sw=2
	autocmd FileType CoffeeScript,*.coffee set ts=2
	autocmd FileType CoffeeScript,*.coffee set sts=2
	autocmd FileType CoffeeScript,*.coffee set expandtab
	autocmd FileType CoffeeScript,*.coffee set textwidth=79

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
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>t :Dispatch<CR>

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" Remap save caps to uncaps
map <leader>WQ :wq<CR>
map <leader>Wq :wq<CR>
map <leader>W  :w<CR>
map <leader>Q  :q<CR>

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
" Open Marked.app
" only works on OSX with Marked.app installed
imap <Leader>m <ESC>:!open -a Marked\ 2.app "%"<CR><CR>
nmap <Leader>m :!open -a Marked\ 2.app "%"<CR><CR>
