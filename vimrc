set autoindent
syntax on
filetype indent plugin on
set tabstop=8
set expandtab
set mouse=a
imap <S-Tab> <C-d>

filetype on
au BufNewFile,BufRead *.pde set filetype=java
au BufNewFile,BufRead *.ino set filetype=cpp

highlight ColorColumn ctermbg=1 guibg=#00cc00
let &colorcolumn="81,120"
"join(range(120,999),",")
