" This file is UTF-8 =========================================================
scriptencoding utf-8
set encoding=utf-8

" Tabs =======================================================================
" default indentation: 4 spaces
set ts=4 sts=4 sw=4 expandtab

" Read .jy files as python.
au BufNewFile,BufRead *.jy set filetype=python

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml set local ts=2 sts=2 sw=2 expandtab

  " House style
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " On save strip trailing whitespace
  autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

endif

" Pathogen ===================================================================
execute pathogen#infect()
filetype plugin on
filetype plugin indent on

let mapleader=","

syntax enable           " Switch on syntax highlighting.
colorscheme solarized
call togglebg#map("<F5>") " F5 wil toggle background. Useful for presenting.

" Layout =====================================================================
set t_ts=]1;          " For iTerm set tab title
set t_fs=             " For iTerm set tab title
set title               " For iTerm set tab title
set rnu                 " Relative line numbering
set number              " And show the line number of current line
set ruler               " Cursor location in bottom bar

" Searching ==================================================================
set ignorecase          " Ignore case when searching.
set smartcase           " Don't ignore case when CAPS in search
set incsearch           " Incremental realtime search (VSlick style)
set hlsearch            " Highlight search
" Turn off the search highlighting with ,/
nmap <silent> ,/ :nohlsearch<CR>

" Window navigation ==========================================================
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Monaco true type: http://www.gringod.com/wp-upload/MONACO.TTF
set gfn=Monaco:h11
set lines=100
set columns=100

" Syntastic ==================================================================
" Available from here: https://github.com/vim-syntastic/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Use my local pylintrc file
let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'
" ============================================================================

" Shortcuts for opening new files ============================================
" See vimcast 14
map <leader>ew :e <C-R>=expand("%:p:h")."/"<CR>
map <leader>es :sp <C-R>=expand("%:p:h")."/"<CR>
map <leader>ev :vsp <C-R>=expand("%:p:h")."/"<CR>
map <leader>et :tabe <C-R>=expand("%:p:h")."/"<CR>
" ============================================================================

set nobackup
set noswapfile   "Re enable this if I need to recover from vim crashes.
"set backupdir=/private/tmp
"set dir=/private/tmp


set hidden                      " Allow creation of hidden buffers w/o warning.
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode.

set wildignore=*.swp,*.pyc
set showmatch                   " Flash the closing bracket when writing ({[
set undolevels=1000
set history=1000
"set visualbell
set noerrorbells

" Keys i keep accidentally hitting!
nmap <F1> <nop>
map <F1> <Esc>
imap <F1> <Esc>
nmap <F1> <Esc>

" Edit config file
nmap <silent> <leader>ec :tabe $MYVIMRC<CR>
nmap <silent> <leader>sc :so $MYVIMRC<CR>

" Toggle whitespace hints with ,l
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,space:·,eol:¬   " Textmate whitespace chars.

" Windows copy paste.
" CTRL-X is Cut
vnoremap <C-x> "+x
" CTRL-C is Copy
vnoremap <C-c> "+y
" SHIFT-Insert is Paste
map <S-Insert>          "+gp

" Chrome like tab control in Windows.
map <C-PageUp>    :tabprevious<CR>
map <C-PageDown>  :tabnext<CR>

" Hard mode. Disallow arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" force root privaleges
cmap w!! w !sudo tee % >/dev/null

" Python IDE.
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
"map T :TaskList<CR>
"map P :TlistToggle<CR>
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Trailing Whitespace ========================================================
" Map to ,s
nnoremap <silent> <leader>s :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the replacement:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position.
  let @/=_s
  call cursor(l, c)
endfunction
