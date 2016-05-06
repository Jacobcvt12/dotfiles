" -----------------------------------------------------------
"                                                             
" Description: .vimrc file (vim configurations)                    
" Maintainer:	Jacob Carey <jacobcvt12@gmail.com>          
"
" -----------------------------------------------------------

" 1. General Settings {{{

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
set cursorline                     " highlight current line
set foldenable                     " enable folding
set foldmethod=indent              " fold based on indent level
set foldlevelstart=10              " open most folds by default
set modelines=1                    " check for vim settings on last line
set autochdir                      " change directory to that of current file

" specify which files are unzipped
let g:zipPlugin_ext = '*.zip,*.jar'

" specify which files are ignored
set wildignore+=*.o,*.pyc,*.Rd,*/inst/doc/*,*.pdf

" convert docx files to markdown on read and vice versa
" http://vi.stackexchange.com/questions/554/is-it-possible-to-easily-work-with-odt-doc-docx-rtf-and-other-non-plain
autocmd BufReadPost *.docx :%!pandoc -f docx -t markdown
autocmd BufWritePost *.docx :!pandoc -f markdown -t docx % > tmp.docx

" close NERDTree on file open
let NERDTreeQuitOnOpen = 1

" }}}
" 2. General Settings (Conditional) {{{

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

" }}}
" 3. General Keyboard Mappings {{{

" remap escape key
" to simultaneous jk
inoremap jk <esc>
inoremap kj <esc>

" enable tab navigation
nnoremap <C-n>  :tabnew<CR>:NERDTreeToggle<CR>
nnoremap <C-j>  :tabnext<CR>
nnoremap <C-k>  :tabprev<CR>

" press control c to copy to mac clipboard
vmap <C-c> :w !pbcopy<CR><CR> 

" use comma as leader
let mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :tabnew<CR>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" change ctrl v to ctrl q so as not to conflict with tmux binding
" THIS DISABLES MACRO RECORDING
nnoremap q <C-v>

" Don't use Ex mode, use Q for formatting
map Q gq

" }}}
" 4. vim-plug {{{

call plug#begin('~/.vim/plugged')

" My Plugins

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'rust'], 'do': './install.py --clang-completer --racer-completer' }
Plug 'scrooloose/syntastic'
Plug 'klen/python-mode', { 'for': 'python' }
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/Vim-R-Plugin', {'for': ['r', 'rout', 'rrst', 'rmd'] }
Plug 'rking/ag.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'sk1418/HowMuch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'

" color schemes
Plug 'AlessandroYorba/Alduin'
Plug 'sickill/vim-monokai'

call plug#end()

" }}}
" 5. Vim-R Settings {{{

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

" }}}
" 6. Vim-airline Settings {{{

let g:airline_theme                         = 'bubblegum'
let g:airline#extensions#syntastic#enabled  = 1
let g:airline_powerline_fonts               = 1
let g:airline#extensions#branch#enabled     = 1
"let g:airline#extensions#tabline#enabled    = 1
set laststatus=2

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
set t_Co=256

" }}}
" 7. Syntastic Settings {{{

" C++ settings
let g:syntastic_cpp_compiler = 'g++-5'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_c_check_header = 1
let b:syntastic_c_cflags = '-I/usr/local/Frameworks/R.framework/Resources/include -I~/.Rlibs/Rcpp/include'

let g:syntastic_enable_r_lintr_checker = 0
let g:syntastic_r_checkers = 0

" }}}
" 8. Git Settings {{{ 

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gc :Git checkout<Space>
nnoremap <leader>gps :Gpush origin master
nnoremap <leader>gpl :Gpull origin master

" }}}
" 9. Silver Searcher Settings {{{

nnoremap <leader>a :Ag!<Space>
let g:ag_working_path_mode="r"

" }}}
" 10. YouCompleteMe Settings {{{

let g:ycm_global_ycm_extra_conf = '~/dotfiles/ycm_extra_conf.py'
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
let g:ycm_autoclose_preview_window_after_insertion = 1

" }}}

" vim:foldmethod=marker:foldlevel=0
