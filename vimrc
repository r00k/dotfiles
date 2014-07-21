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
  autocmd FileType go set ai sw=4 sts=4 et
  au FileType go au BufWritePre <buffer> Fmt
augroup END

" Aliases
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
