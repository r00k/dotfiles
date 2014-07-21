execute pathogen#infect()
" Theme and stuff
set background=dark
colorscheme solarized

set cc=80   " Highlight column 80
set number  " show number lines
set mouse=a " use the mouse luke
" New Leader
let mapleader = ","
let g:mapleader = ","

" Indentation

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
	autocmd FileType ruby let b:dispatch = 'testrb %'

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

	" Golang
	autocmd FileType go set ai sw=4 sts=4 et
	au FileType go au BufWritePre <buffer> Fmt
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

"show trailing spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

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
