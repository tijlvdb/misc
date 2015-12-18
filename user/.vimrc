" display mode INSERT/REPLACE/...
set showmode
set showcmd
set shiftwidth=2
set shiftround
set expandtab
set autoindent
set tabstop=2
" don't show line numbers
set nonumber
filetype on
autocmd FileType perl set smartindent
autocmd FileType html set formatoptions+=tl
autocmd FileType html,css set noexpandtab tabstop=2
autocmd FileType css set smartindent
 "   For *.c and *.h files set formatting of comments and set C-indenting on.
autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
" duh, can it be any more clean? syntax highlighting on
syntax on
"
" backspace fixes... need this on hpux :) Ctrl-H don't cut it
set backspace=eol,start,indent
"
" vim ONLY, breaks some vi compatibility 
set nocompatible
"
" show cursor line and column in the status line
set ruler
"
" highlight search... IEK we don't want that in red !!!
" set hlsearch
" set nohlsearch
"
" No bloody beeps
set noerrorbells
" show uncompleted commands, tab'm to show :)
set showcmd
" default tab expansion, but you can change to C-E or such
" set   wildchar=<TAB> 
"
" startofline:  no:  do not jump to first character with page
" commands, ie keep the cursor in the current column.
set nostartofline
" Enabled for user
set modeline
" # vim: set syntax=diff
" # vim: set syntax=apache
