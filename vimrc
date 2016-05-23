set autoindent
syntax on
filetype indent plugin on
set tabstop=8
set expandtab
set mouse=a

" unindent keybind
imap <S-Tab> <C-d>

" enable filetype based syntax highlighting
filetype on

" enable syntax highlighting for Processing and Arduino
au BufNewFile,BufRead *.pde set filetype=java
au BufNewFile,BufRead *.ino set filetype=cpp
au BufNewFile,BufRead *.rs set filetype=rust

" remove .netrwhist files
au VimLeave * if filereadable("[path here]/.netrwhist")|call delete("[path here]/.netrwhist")|endif
