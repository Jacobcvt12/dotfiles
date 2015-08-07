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
" 8. Git Settings
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

set backupdir=~/.vim/backup//      " set backup directory
set directory=~/.vim/swap_files//  " save .swp files here instead
set history=50		               " keep 50 lines of command line history
set ruler		                   " show the cursor position all the time
set showcmd		                   " display incomplete commands
set incsearch		               " do incremental searching

" specify which files are unzipped
let g:zipPlugin_ext = '*.zip,*.jar'

" convert docx files to markdown on read and vice versa
" http://vi.stackexchange.com/questions/554/is-it-possible-to-easily-work-with-odt-doc-docx-rtf-and-other-non-plain
autocmd BufReadPost *.docx :%!pandoc -f docx -t markdown
autocmd BufWritePost *.docx :!pandoc -f markdown -t docx % > tmp.docx


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

" Switch syntax highlighting on
syntax on

" Highlight search matches
set hlsearch

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
nnoremap q <C-v>

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
Plugin 'ivanov/vim-ipython'
Plugin 'bling/vim-airline'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/Vim-R-Plugin'
Plugin 'jpalardy/vim-slime'
Plugin 'rking/ag.vim'

" YouCompleteMe " support for clang

let g:ycm_global_ycm_extra_conf = '~/dotfiles/ycm_extra_conf.py'
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'

" Change slime to use tmux
let g:slime_target = "tmux"
let g:slime_python_ipython = 1

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
let g:airline#extensions#tabline#enabled    = 1
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
let g:syntastic_cpp_compiler = 'g++-5'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_c_check_header = 1
let b:syntastic_c_cflags = '-I/usr/local/Frameworks/R.framework/Resources/include -I~/.Rlibs/Rcpp/include'
 
" ------------------------------
"                  
" 8. Git Settings
"                  
" ------------------------------

nnoremap <leader>gs :Gstatus<CR>
