" plug-vim setup
call plug#begin('~/.vim/plugged')

    " plugin management
    Plug 'gmarik/Vundle.vim'                            " vundle
    
    " visual changes
    Plug 'vim-airline/vim-airline'                      " airline status bar
    Plug 'vim-airline/vim-airline-themes'               " airline status bar themes
    Plug 'frazrepo/vim-rainbow'                         " coloured parentheses
   
    " file management
    Plug 'vifm/vifm.vim'                                " vifm
    Plug 'scrooloose/nerdtree'                          " nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " nerdtree hightliting
    Plug 'ryanoasis/vim-devicons'                       " nerdtree icons
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf - file finder
    Plug 'junegunn/fzf.vim' 

    " helpers
    Plug 'vimwiki/vimwiki'                              " vimwiki 
    Plug 'jreybert/vimagit'                             " vimagit - git helper

    " writing
    Plug 'tpope/vim-surround'                           " changnig the wrappers around expressions

    " highliting
    Plug 'vim-python/python-syntax'                     " python highliting 
    Plug 'ap/vim-css-color'                             " colour previews for CSS

    " focus and view management
    Plug 'junegunn/goyo.vim'                           " zen-mode 
    Plug 'junegunn/limelight.vim'                      " focus on a section of code 

call plug#end()

filetype plugin indent on    " required

" settings

set nobackup                    " no backups
set noswapfile                  " turning off generation of swapfiles

set path+=**					" searching direcotry recursively
set wildmenu					" autocomplete on tab
set incsearch                   " incremental search
set hidden                      " multiple buffers
set t_Co=256                    " 256 colors if supported.
set number relativenumber       " line numbers
set clipboard=unnamedplus       " global clipboard support.

syntax enable
let g:rehash256 = 1

" mapping escape to exit instert mode
:imap ii <Esc>

" always show the status bar
set laststatus=2

" airline customization
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ' ' 
"let g:airline_left_sep = '▶'
let g:airline_right_sep = ' '
"let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
set linespace=0

" non-normal modes showing in powerline and below powerline.
set noshowmode

" identation settings
set expandtab                   " replaces tab with adequate number of spaces 
set smarttab                    " properly verifies how many spaces are left for a proper tab 
set shiftwidth=4                " one space equivalent set tabstop=4                   "                      to four spaces 

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

" colouring and themes
highlight Normal           guifg=#dfdfdf ctermfg=15   guibg=#282c34 ctermbg=none  cterm=none
highlight LineNr           guifg=#5b6268 ctermfg=8    guibg=#282c34 ctermbg=none  cterm=none
highlight CursorLineNr     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
highlight VertSplit        guifg=#1c1f24 ctermfg=0    guifg=#5b6268 ctermbg=8     cterm=none
highlight Statement        guifg=#98be65 ctermfg=2    guibg=none    ctermbg=none  cterm=none
highlight Directory        guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
highlight StatusLine       guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
highlight StatusLineNC     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
highlight NERDTreeClosable guifg=#98be65 ctermfg=2
highlight NERDTreeOpenable guifg=#5b6268 ctermfg=8
highlight Comment          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic
highlight Constant         guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
highlight Special          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
highlight Identifier       guifg=#5699af ctermfg=6    guibg=none    ctermbg=none  cterm=none
highlight PreProc          guifg=#c678dd ctermfg=5    guibg=none    ctermbg=none  cterm=none
highlight String           guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
highlight Number           guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
highlight Function         guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none

" highlight WildMenu         ctermfg=0       ctermbg=80      cterm=none
" highlight Folded           ctermfg=103     ctermbg=234     cterm=none
" highlight FoldColumn       ctermfg=103     ctermbg=234     cterm=none
" highlight DiffAdd          ctermfg=none    ctermbg=23      cterm=none
" highlight DiffChange       ctermfg=none    ctermbg=56      cterm=none
" highlight DiffDelete       ctermfg=168     ctermbg=96      cterm=none
" highlight DiffText         ctermfg=0       ctermbg=80      cterm=none
" highlight SignColumn       ctermfg=244     ctermbg=235     cterm=none
" highlight Conceal          ctermfg=251     ctermbg=none    cterm=none
" highlight SpellBad         ctermfg=168     ctermbg=none    cterm=underline
" highlight SpellCap         ctermfg=80      ctermbg=none    cterm=underline
" highlight SpellRare        ctermfg=121     ctermbg=none    cterm=underline
" highlight SpellLocal       ctermfg=186     ctermbg=none    cterm=underline
" highlight Pmenu            ctermfg=251     ctermbg=234     cterm=none
" highlight PmenuSel         ctermfg=0       ctermbg=111     cterm=none
" highlight PmenuSbar        ctermfg=206     ctermbg=235     cterm=none
" highlight PmenuThumb       ctermfg=235     ctermbg=206     cterm=none
" highlight TabLine          ctermfg=244     ctermbg=234     cterm=none
" highlight TablineSel       ctermfg=0       ctermbg=247     cterm=none
" highlight TablineFill      ctermfg=244     ctermbg=234     cterm=none
" highlight CursorColumn     ctermfg=none    ctermbg=236     cterm=none
" highlight CursorLine       ctermfg=none    ctermbg=236     cterm=none
" highlight ColorColumn      ctermfg=none    ctermbg=236     cterm=none
" highlight Cursor           ctermfg=0       ctermbg=5       cterm=none
" highlight htmlEndTag       ctermfg=114     ctermbg=none    cterm=none
" highlight xmlEndTag        ctermfg=114     ctermbg=none    cterm=none

" vifm configuration
map <Leader>vv :Vifm<CR>
map <Leader>vs :VsplitVifm<CR>
map <Leader>sp :SplitVifm<CR>
map <Leader>dv :DiffVifm<CR>
map <Leader>tv :TabVifm<CR>

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" markup
let g:instant_markdown_autostart = 0         " turns off auto-preview
let g:instant_markdown_browser = "firefox"   " firefox as a browser (subject to change) 
map <Leader>md :InstantMarkdownPreview<CR>   " previous .md file
map <Leader>ms :InstantMarkdownStop<CR>      " kill the preview 

" terminal inside vim
map <Leader>tt :vnew term://fish<CR>

" mouse scrolling
set mouse=nicr
set mouse=a

" alacritty resize bug
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

" split to tabs
set splitbelow splitright

" split in defined direction
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" adjust the size
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" toggling between the orientation - horizontal -> vertical &&
" vertical -> horizontal
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" removes the pipes
set fillchars+=vert:\ 

" python highlighting
let g:python_highlight_all = 1

" other options left to organise
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=SauceCodePro\ Nerd\ Font:h15
