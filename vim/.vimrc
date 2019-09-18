" Axel Fahy - 17.09.2019
" /etc/vim/vimrc or ~/.vimrc
" Vim configuration file

" Set Python3
let g:powerline_pycmd = 'py3'
" Set tmp directory
set directory=~/.vim/tmp//
" Maintain undo history between sessions
set undofile
" Location of tmp files for history of sessions
set undodir=~/.vim/tmp


"==============================================================================
" PLUGINS - VIM-PLUG

" Automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" a.vim - switch between source and header
Plug 'vim-scripts/a.vim'

" Bash
Plug 'vim-scripts/bash-support.vim'

" C
Plug 'vimscript/c-support'

" Vim-Colorscheme
Plug 'flazz/vim-colorschemes'

" CSS
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Doxygen comments
Plug 'vim-scripts/DoxygenToolkit.vim'

" Fish scripts
Plug 'dag/vim-fish'

" Git plugin
Plug 'tpope/vim-fugitive'

" Go language
Plug 'fatih/vim-go', { 'for': 'go' }

" Jade
Plug 'digitaltoad/vim-jade', { 'for': 'pug' }

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" JSON
Plug 'elzr/vim-json'

" HTML5
Plug 'othree/html5.vim', { 'for': 'html' }

" Jedi-vim autocompletion Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Vim-Flake8 (PEP8 checker for Python, ...)
Plug 'nvie/vim-flake8'

" LanguageTool
Plug 'vim-scripts/LanguageTool'

" LateX
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }

" Markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" The NERD commenter - Plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" The NERD tree - A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'

" Octave
Plug 'vim-scripts/octave.vim--', { 'for': 'octave' }

" Powerline
Plug 'powerline/powerline'

" ReStructuredText
Plug 'rykka/riv.vim', { 'for': 'rst' }

" Scala
Plug 'derekwyatt/vim-scala', { 'for': ['scala', 'sc'] }

" Vim-slim syntax highlighting
Plug 'slim-template/vim-slim'

" Syntastic - Syntax hacks for vim
function! Installjshint(info)
    if a:info.status == 'installed' || a:info.force
        !sudo npm install -g jshint
    endif
endfunction
Plug 'scrooloose/syntastic', { 'do': function('Installjshint') }

" Tags - require 'exuberant-ctags' package
Plug 'vim-scripts/taglist.vim'

" Vim-Airline (include buffers handler)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Show trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" Vimproc - Interactive command execution
Plug 'Shougo/vimproc.vim'

" Unite and create user interfaces
function! BuildUnite(info)
    if a:info.status == 'installed' || a:info.force
        !make
    endif
endfunction
"   depend on vimproc
"   ------------- VERY IMPORTANT ------------
"   you have to go to .vim/plugin/vimproc.vim and do a ./make
"   -----------------------------------------
Plug 'Shougo/unite.vim', { 'do': function('BuildUnite') }

" YouCompleteMe - Code-completion
"function! BuildYCM(info)
"    if a:info.status == 'installed' || a:info.force
"        !./install.sh
"    endif
"endfunction
"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }


" All of your Plugins must be added before the following line
call plug#end()


"==============================================================================
set nocompatible                        " Be iMproved, required
"==============================================================================
" TABS
set tabstop=4                           " Number of visual spaces per tab
set softtabstop=4                       " Number of spaces in tab when editing
set expandtab                           " tabs are spaces (spaces are not converted into tabs)
set shiftwidth=4

" Uncomment to have tabs and spaces in blue
"set list
"set listchars=tab:>-,trail:-

set vb                                  " Visual bell instead of beep
syntax on                               " Enable syntax coloration


"==============================================================================
" COLORS
" Colorscheme (different for gvim)
if has('gui_running')           " GVim colorscheme
    " colorscheme murphy
    colorscheme jellybeans
else                            " Vim colorscheme
    "colorscheme railscasts
    colorscheme molokai
    "let g:solarized_termcolors=256
    "set background=dark
    "colorscheme solarized
endif

set number                              " Show line numbers
set relativenumber                      " Show relative line numbers

set mouse=a                             " Activate mouse support
set ruler                               " Print cursor position

" Max width size of text
" '72' wraps at 72 characters
" '0' turn of the function
set textwidth=0
" Wraps at 72 characters with touch '#'
map # gwap
set tw=0                                " Remove auto-wrapping

set nocompatible                        " Remove compatibility with Vi
set nocp                                " Enable option not compatible with Vi
"set columns=80                         " Number of columns (useless)
set history=50                          " Number of commands in history
set viminfo='20,\"50                    " Option of file ~/.viminfo
set backspace=2                         " Activate backspace key
set whichwrap=<,>,[,]                   " Allow switching between lines with arrows (left / right)
set scrolloff=1                         " Keeps always one line visible on the screen above the cursor
set showmatch                           " Display pair of parenthesis
"set nostartofline                      " Keeps the cursor on the same column when switching lines
set wildmode=list:full                  " Automatic auto completion

set foldmethod=indent                   " Folder based on indentation
set foldlevel=12                        " Level of indentation for folders

" Remove all trailing whitespace when saving
autocmd BufWritePre <buffer> :%s/\s\+$//e

" Automatically active spelling for certain type of files
autocmd FileType markdown setlocal spell

"==============================================================================
" STATUS BAR
set showcmd                             " Show commands on status bar
set showmode                            " Always show status line
set laststatus=2                        " Print status bar in all windows
set statusline=%<%f%h%m%r%=%l,%c\ %P    " Content of status bar


"==============================================================================
" IDENTATION
set noautoindent                        " Don't keep previous indentation when starting a new line
set ai                                  " Smart identation
set smartindent
set cindent
set cinoptions=(0                       " Identation option for a C file


"==============================================================================
" SEARCH
set ignorecase                          " Search are not case sensitives
set incsearch                           " Search as characters are entered
set hlsearch                            " Highlight matches
" F3 turn off search highlight (toggle)
nnoremap <F3> :set hlsearch!<CR>

"==============================================================================
" BUFFERS
set hidden                              " Allows to change buffer without saving first

"==============================================================================
" SHOW 80th COLUMN
"if (exists('+colorcolumn'))
"    set colorcolumn=80
"    highlight ColorColumn ctermbg=9
"endif


"==============================================================================
" GLOBAL MAPPING

" Workaround for Alt key in terminal
"TODO

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
" Alt mapping not working
nnoremap <silent><A-j>:set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k>:set paste<CR>m`O<Esc>``:set nopaste<CR>
"nnoremap <silent><M-j>:set paste<CR>m`o<Esc>``:set nopaste<CR>
"nnoremap <silent><M-k>:set paste<CR>m`O<Esc>``:set nopaste<CR>
"
" Switch between buffers with arrow of 'h' and 'l'
noremap <C-Left> :bprev<CR>
noremap <C-Right> :bnext<CR>
noremap <C-h> :bprev<CR>
noremap <C-l> :bnext<CR>


"==============================================================================
" WRAPPING
let mapleader = '\'
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction


"==============================================================================
" MOVEMENTS
" Movements are made on displayed lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

"==============================================================================
" TEMPLATES AND MAPPING FOR LANGUAGE

"===========================================================
" Autocompletion
" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


"===========================================================
" Bash
let g:BASH_AuthorName   = 'Axel Fahy'
let g:BASH_AuthorRef    = ''
let g:BASH_Email        = 'axel@fahy.net'
let g:BASH_Company      = ''


"===========================================================
" C
" Modification of template in :
" '.vim/bundle/c-support/c-support/templates/Templates'
let g:C_UseTool_doxygen = 'yes'         " Support for doxygen
" Extensions for template
let g:C_SourceCodeExtensions = 'c cc cp cxx cpp CPP c++ C i ii h'
" Mapping for C compilation <F6> for basic compilation
map <F6> :call CompileC()<cr>
func! CompileC()
    exec "w"
    exec "!gcc -std=c99 -Wall -lm % -o %<"
endfunc

" Mapping for C compilation <F7> for basic compilation and run
map <F7> :call CompileCRun()<cr>
func! CompileCRun()
    exec "w"
    exec "!gcc -std=c99 -Wall -lm % -o %<"
    exec "! ./%<"
endfunc


"===========================================================
" LanguageTool
" LanguageTool location
let g:languagetool_jar='/opt/LanguageTool/languagetool-commandline.jar'


"===========================================================
" Latex
" Default format
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
" Remove auto folding
let g:Tex_AutoFolding = 0
let g:tex_flavor='Latex'                " Set type of file to latex if empty


"===========================================================
" Octave files
augroup filetypedetect
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END


"===========================================================
" Airline - automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" Powerline fonts with airline
" If using urxvt, needs not install compatible fonts
let g:airline_powerline_fonts = 1
" build tags of your own project with CTRL+F12
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
"inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>


"===========================================================
" vimproc / unite
let g:unite_source_history_yank_enable = 1
try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
"nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <space><space> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)


"===========================================================
" Digraphs
" To run: CTRL-K followed by the letter, in insert mode
" ±
:dig pm 177
" ²
:dig 22 178
" ∏
:dig PI 8719
" ∑
:dig SM 8721
" √
:dig sq 8730
" ∞
:dig if 8734
" Γ
:dig GG 915
" Δ
:dig DD 916
" α
:dig aa 945
" β
:dig bb 946
" γ
:dig gg 947
" δ
:dig dd 948
" ε
:dig ee 949
" η
:dig nn 951
" μ
:dig mu 956
" τ
:dig ta 964
" λ
:dig ll 955
" π
:dig pi 960
" σ
:dig ss 963

