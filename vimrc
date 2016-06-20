syntax on

" default indent options
set autoindent
filetype indent plugin on
set tabstop=8
set expandtab

" mouse support
set mouse=a
set tags=./tags;/

" unindent keybind
imap <S-Tab> <C-d>

" fast redraws
" set ttyfast

" newline with enter
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" highlight trailing whitespace
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" enable filetype based syntax highlighting
filetype on

" enable syntax highlighting for Processing and Arduino
au BufNewFile,BufRead *.pde set filetype=java
au BufNewFile,BufRead *.ino set filetype=cpp
au BufNewFile,BufRead *.rs set filetype=rust

" remove .netrwhist files
au VimLeave * if filereadable("[path here]/.netrwhist")|call delete("[path here]/.netrwhist")|endif
