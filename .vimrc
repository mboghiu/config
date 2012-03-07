colorscheme rdark

"
" Highlight errors
"
function! HighlightErrors()

	highlight Error ctermbg=red ctermfg=white guibg=#d72323 guifg=white
	match Error /^[ \s]+\|\s\+$\|[^\t]\t\+\|\t \|\%102v.*/

endfunction


"
" Execute window command
"
function WindowCommand(command)
	execute "wincmd " . a:command
endfunction

set guioptions-=T
set guioptions-=m
set shiftwidth=4
set expandtab
set tabstop=4
set laststatus=2
"set statusline=%F%m%r%h%w\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%w\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set scrolloff=5
set ignorecase
"Sets in-line spellchecking (including local spell check: UK)
"set spell
"setlocal spell spelllang=en_gb
set number
set tabstop=4
set noeb
set hlsearch
set incsearch
set autoindent
set bg=dark
set mouse=v

" F6 to open WinManager Explorer
nnoremap <F6> :WMToggle <CR>

" Theme settings
syntax enable
"syn off

" Window navigation
map <C-K> :call WindowCommand('k')<CR>
map <C-J> :call WindowCommand('j')<CR>
map <C-H> :call WindowCommand('h')<CR>
map <C-L> :call WindowCommand('l')<CR>

" highlight errors when opening new buffers or windows
autocmd BufWinEnter * call HighlightErrors()
autocmd WinEnter    * call HighlightErrors()
autocmd BufRead     *.as set filetype=actionscript
autocmd BufRead     *.mxml set filetype=mxml

" These settings are needed for latex-suite
"filetype indent on
"filetype plugin on
"filetype on
"let g:tex_flavor='latex'
"set grepprg=grep\ -nH\ $*
" let g:Tex_Folding=0 "I don't like folding.
" set iskeyword+=:
