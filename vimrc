" -----------------------------------------------------------
"                                                             
" Description: .vimrc file (vim configurations)                    
" Maintainer:	Jacob Carey <jacobcvt12@gmail.com>          
"
" Sections:
" 1. General Settings (Set)
" 2. General Settings (Conditional)
" 3. General Keyboard Mappings
" 4. Vundle Settings
" 5. Vim-R Settings          
" 6. Vim-airline Settings
" 7. Syntastic Settings
" -----------------------------------------------------------

" ------------------------------
"                  
" 1. General Settings (Set)
"                  
" ------------------------------

" Use Vim settings, rather than Vi settings 
" This must be first, because it changes other options as a side effect.
set nocompatible

" make backspace work like most other apps
set backspace=indent,eol,start

" enable hybrid rnu
set relativenumber
set number

" change tabstop
set tabstop=4
set shiftwidth=4
set expandtab

set backupdir=~/.vim/backup     " set backup directory
set history=50		            " keep 50 lines of command line history
set ruler		                " show the cursor position all the time
set showcmd		                " display incomplete commands
set incsearch		            " do incremental searching


" -----------------------------------
"                  
" 2. General Settings (Conditional)
"                  
" -----------------------------------

" Vim requires a POSIX-compliant shell. Set shell to be bash
" if SHELL environment variable contains /fish
if $SHELL =~ '/fish'
    set shell=/usr/local/bin/bash
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END

else
  set autoindent		" always set autoindenting on
endif 

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" ------------------------------
"                  
" 3. General Keyboard Mappings
"                  
" ------------------------------

" remap escape key
" to simultaneous jk
inoremap jk <esc>
inoremap kj <esc>

" enable tab navigation
nnoremap <C-n>  :tabnew<CR>:e .<CR>
nnoremap <C-j>  :tabnext<CR>
nnoremap <C-k>  :tabprev<CR>

" press control c to copy to mac clipboard
vmap <C-c> :w !pbcopy<CR><CR> 

" change ctrl v to ctrl q so as not to conflict with tmux binding
" THIS DISABLES MACRO RECORDING
:nnoremap q <c-v>

" Don't use Ex mode, use Q for formatting
map Q gq

" ---------------------
"                  
" 4. Vundle & Plugins 
"                  
" ---------------------

" system setup

filetype off 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on

" My Plugins

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/SearchComplete'
Plugin 'vim-scripts/sql_iabbr.vim'
Plugin 'ivanov/vim-ipython'
Plugin 'bling/vim-airline'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/Vim-R-Plugin'
Plugin 'xuhdev/vim-latex-live-preview'

" YouCompleteMe " support for clang

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'

" latex live preview
let g:livepreview_previewer = 'open -a Preview'

" ---------------------
"                  
"  5. Vim-R Settings  
"                  
" ---------------------

" Open R session in Terminal

let vimrplugin_applescript = 0
let vimrplugin_screenplugin = 0

" R keyboard mappings

"start R with F2 key
map <F2> <Plug>RStart 
imap <F2> <Plug>RStart
vmap <F2> <Plug>RStart

" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection 

" send line to R with space bar
nmap <Space> <Plug>RDSendLine

" ------------------------
"                  
"  6. Vim-airline Settings  
"                  
" ------------------------

let g:airline_theme                         = 'bubblegum'
let g:airline#extensions#syntastic#enabled  = 1
let g:airline_powerline_fonts               = 1
let g:airline#extensions#branch#enabled     = 1
set laststatus=2

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
set t_Co=256

" ------------------------------
"                  
" 7. Syntastic Settings
"                  
" ------------------------------

" include directories for Rcpp compilation
let g:syntastic_cpp_compiler = 'g++-4.9'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_c_check_header = 1
let b:syntastic_c_cflags = '-I/usr/local/Cellar/r/3.1.2_1/R.framework/Resources/include -I/usr/local/Cellar/r/3.1.2_1/R.framework/Versions/3.1/Resources/library/Rcpp/include'
 
