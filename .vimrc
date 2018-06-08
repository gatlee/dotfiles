set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" THEMES
Plugin 'morhetz/gruvbox' 
Plugin 'colepeters/spacemacs-theme.vim'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'altercation/vim-colors-solarized'
Plugin 'lifepillar/vim-solarized8'

Plugin 'mikewest/vimroom'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-surround'
Plugin 'unblevable/quick-scope'     
Plugin 'tbabej/taskwiki'
Plugin 'wincent/terminus'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'

"Plugin 'lervag/wiki'
" 
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
"

"FROM WINDOWS


" configure epanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set expandtab
au BufRead,BufNewFile *.h set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" --------------------------------------------------------------------------------
"  " configure editor with tabs and nice stuff...
"  "
"  --------------------------------------------------------------------------------
  syntax on
  set expandtab           " enter spaces when tab is pressed
  set textwidth=120       " break lines when line length increases
  set tabstop=4           " use 4 spaces to represent tab
  set softtabstop=4
  set shiftwidth=4        " number of spaces to use for auto indent
  set autoindent          " copy indent from current line when starting a new"

  set backspace=indent,eol,start      " make backspaces more powerfull
  set ruler							  " show line and column number
  syntax on							  " syntax highlighting
  set showcmd						  " show (partial) command in status line
  set relativenumber

" Auto compile and run
" nnoremap <F5> :w <bar> !cpy % 
au BufEnter *.c noremap <F6> :w <CR> :!clear && gcc -Wall % -o %< && %<
au BufEnter *.c noremap <F5> :w <CR> :!clear && gcc -Wall % -o %< && ./%<
au BufEnter *.py noremap <F5> :w <CR> :!python %
au BufEnter *.py noremap <F6> :w <CR> :!python -i %
au BufEnter *.hs noremap <F5> :w <CR> :!ghci %
au BufEnter *.md noremap <F5> :w <CR> :!pandoc -o %<.html % && qutebrowser %<.html

au BufEnter *.c match Type /\w*_t/

" Vimdragging
" Located in .vim/plugins/dragvisuals.vim

runtime plugin/dragvisuals.vim                             

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')                      
vmap  <expr>  D        DVB_Duplicate()                     
                                                           
" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1                                       

" Display all matching files when we tab complete
set wildmenu
" Finding files 
set path+=**

set colorcolumn=81
set noeb vb t_vb=
set nowrap
"Auto reload vimrc"
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

"Fix true colour?
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"Added from linux
set background=dark

colorscheme hybrid_material
let g:solarized_term_italics = 1
let g:solarized_termcolors=256

set t_Co=256
set termguicolors

let g:gruvbox_bold = '1'
let g:gruvbox_contrast_dark = 'hard'


"Vim bar filename bottom thing
set relativenumber

"Cursor changing style (old bash shell)
"au InsertEnter * silent execute "!echo -en \<esc>[5 q"
"au InsertLeave * silent execute "!echo -en \<esc>[2 q"


if has("autocmd")
    autocmd InsertEnter,InsertLeave * set cul!
endif


"Convenience remaps <LEADER> 

let mapleader=' '
map <Leader>vc :e ~/.vimrc <Enter>
map <Leader>V <Plug>VimroomToggle
map <Leader>td iTODO:


function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let link = a:link
    if link =~# '^vfile:' || link =~# '^vlocal:'
        let link = link[1:]
    else
        return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        exe 'tabnew ' . fnameescape(link_infos.filename)
        return 1
    endif
endfunction



let g:vimwiki_list = [{'path': '~/my_site/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]


" let g:wiki_root = '~/Documents/wiki'


" Makes background transparent
"hi Normal guibg=NONE ctermbg=NONE
