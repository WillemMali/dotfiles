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

" for using vim as a pager for man
let $PAGER=''
