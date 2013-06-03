colorscheme impact

"---------------------------------------------------------------------------------------
" Highlight errors
"---------------------------------------------------------------------------------------

function! HighlightErrors()
	highlight Error ctermbg=red ctermfg=white guibg=#d72323 guifg=white
	match Error /^[ \s]+\|\s\+$\|[^\t]\t\+\|\t \|\%102v.*/
endfunction

"---------------------------------------------------------------------------------------
" Execute window command
"---------------------------------------------------------------------------------------

function WindowCommand(command)
	execute "wincmd " . a:command
endfunction

"---------------------------------------------------------------------------------------
" GVim options
"---------------------------------------------------------------------------------------

set guioptions-=T "remove toolbar
set guioptions-=m "remove menu bar
set bg=dark
set mouse=v       "a=enable mouse use; v=??

"---------------------------------------------------------------------------------------
" Insert control
"---------------------------------------------------------------------------------------

set shiftwidth=4  "control how many columns text is indented with << and >>
set expandtab     "turn tabs into spaces
set tabstop=4     "how many spaces in a tab
set shiftwidth=4
set softtabstop=4
set laststatus=2  "show status line 0=never, 1(default)=only for >=2 windows, 2=always
set scrolloff=5   "how many lines you want above and below the cursor
"set ignorecase   "case insensitive searching/replacing

"---------------------------------------------------------------------------------------
" Status line options
"---------------------------------------------------------------------------------------

"set statusline=%F%m%r%h%w\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%w\ [position=%04l,%04v][%p%%]\ [LEN=%L]

"set statusline=%t                               "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}]                         "file format

"---------------------------------------------------------------------------------------
" Spellchecking
"---------------------------------------------------------------------------------------

"set spell        "sets in-line spellchecking (including local spell check: UK)
"setlocal spell spelllang=en_gb

"---------------------------------------------------------------------------------------
" Misc display
"---------------------------------------------------------------------------------------

set number          "show line numbers
set noeb            "set no error bells
set hlsearch        "highlight search results
set incsearch       "set incremental searches (i.e. search as you type)
set autoindent      "turn on auto indent
set tabpagemax=153 "tax number of tabs (default is much smaller)

" F6 to open WinManager Explorer
" nnoremap <F6> :WMToggle <CR>

" Theme settings
syntax enable
set syntax=cpp11
"set foldmethod=syntax
au BufNewFile,BufRead *.cpp set syntax=cpp11
au BufNewFile,BufRead *.rule set syntax=cpp11

"---------------------------------------------------------------------------------------
" Window navigation
"---------------------------------------------------------------------------------------

nnoremap <C-Up> gT
nnoremap <C-Down> gt


noremap <ScrollWheelUp>      <nop>
noremap <S-ScrollWheelUp>    <nop>
noremap <C-ScrollWheelUp>    <nop>
noremap <ScrollWheelDown>    <nop>
noremap <S-ScrollWheelDown>  <nop>
noremap <C-ScrollWheelDown>  <nop>
noremap <ScrollWheelLeft>    <nop>
noremap <S-ScrollWheelLeft>  <nop>
noremap <C-ScrollWheelLeft>  <nop>
noremap <ScrollWheelRight>   <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>

"---------------------------------------------------------------------------------------
" highlight errors when opening new buffers or windows
"---------------------------------------------------------------------------------------

"autocmd BufWinEnter * call HighlightErrors()
"autocmd WinEnter    * call HighlightErrors()
autocmd BufRead     *.as set filetype=actionscript
autocmd BufRead     *.mxml set filetype=mxml

"---------------------------------------------------------------------------------------
" LaTeX settings
"---------------------------------------------------------------------------------------

"filetype indent on
"filetype plugin on
"filetype on
"let g:tex_flavor='latex'
"set grepprg=grep\ -nH\ $*
"let g:Tex_Folding=0 "I don't like folding.
"set iskeyword+=:

"---------------------------------------------------------------------------------------
" CTags settings
"---------------------------------------------------------------------------------------

" map <ctrl>+F12 to generate ctags for current folder:
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=~/.vim/tags/flex.tags
set tags+=~/.vim/tags/stl.tags
set tags+=~/.vim/tags/tags
set tags+=./tags

"---------------------------------------------------------------------------------------
" Controls
"---------------------------------------------------------------------------------------
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

inoremap jj <Esc>
set timeoutlen=250
set cursorline

"au! BufWritePost .vimrc source %

"---------------------------------------------------------------------------------------
" C++ settings
"---------------------------------------------------------------------------------------

" Turn class declaration into empty class definition C++
call setreg('g', '0JO%jv/{:s/:\s*\w\+\s\+\S\+\s*{/{/e/{b"wye?%jv/{:s/\w\+\s\+\w\+\s\+{/{/?%xv/{�kb"eyj"wP:s/template\(<[^>]*>\)/\1/e:s/\w\+\s\+\(\w\+.\)\(\s*\)/\1/ge0v/{:s/\(\S\){/\1 {/ev/{�kb�kb"rdkv/{c{vi{10<:''<,''>g/^$/d?{vi{:g/^virtual .*=\s*0\s*;\s*$/de:''<,''>s/^virtual //e:''<,''>s/^static //e:''<,''>s/^\(\s*template<[^>]*>\)\s*\n\s*\(\(const\s\+\)\?\S\+\s\+\w\+(.*).*;\)\s*$/\1 \2/e?{vi{:s/^\(\~\?w(\)/%none% \1/e:''<,''>s/\/\/.*$//e:''<,''>v/\(template<[^>]*> \)\?\(const\s\+\)\?\S\+\s\+\~\?\w\+([^)]*).*;\s*$/d?{vi{:s/^\(template<[^>]*> \)\?\(const\s\+\)\?\(\S\+\)\s\+\(\S\+([^)]*).*\);\s*$/e\1\2\3 r::\4{}//};vi{:s/^\(template<[^>]*> \)\(\(const\s\+\)\?\S\+\s\+\S\+(.*\)$/\1\2/e:''<,''>s/%none% //e/};%xi////////// "wpA ///////////};xx?/0')
"
call setreg('h', 'i#ifndef %gUaW:s/\./_/Wyeo#define "#endif  // "gg')
call setreg('c', 'caw /**/jjhPbhx')
call setreg('u', '/\/\*2xw2x')
call setreg('o', '/{v]}do')
call setreg('a', 'ggVG')
call setreg('b', '$xo{}j')
call setreg('t', '0i////////// A //////////')
