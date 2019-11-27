" Axel Fahy - 21.11.2019
" /etc/vim/vimrc or ~/.vimrc
" Vim configuration file

"==============================================================================
" PLUGINS - VIM-PLUG

" Automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"======================================
" Language plugins

" a.vim - switch between source and header
Plug 'vim-scripts/a.vim'

" Bash
Plug 'vim-scripts/bash-support.vim'

" Black - formatting for Python
Plug 'ambv/black'

" C
Plug 'vimscript/c-support'

" CSS
Plug 'hail2u/vim-css3-syntax'

" Doxygen comments
Plug 'vim-scripts/DoxygenToolkit.vim'

" Fish scripts
Plug 'dag/vim-fish'

" Go language
Plug 'fatih/vim-go'

" Javascript
Plug 'pangloss/vim-javascript'

" JSON
Plug 'elzr/vim-json'

" HTML5
Plug 'othree/html5.vim'

" Vim grammarous
Plug 'rhysd/vim-grammarous'

" LateX
Plug 'LaTeX-Box-Team/LaTeX-Box'

" Markdown
Plug 'tpope/vim-markdown'

" Octave
Plug 'jvirtanen/vim-octave'

" Scala
Plug 'derekwyatt/vim-scala'

" Syntastic - Syntax hacks for vim
function! Installjshint(info)
    if a:info.status == 'installed' || a:info.force
        !sudo npm install -g jshint
    endif
endfunction
Plug 'scrooloose/syntastic', { 'do': function('Installjshint') }

" Show trailing whitespace and fix them
Plug 'bronson/vim-trailing-whitespace'

"======================================
" Utility plugins

" Airline (include buffers handler)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colorschemes pack
Plug 'flazz/vim-colorschemes'

" Conqueror of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fugitive.vim - A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" fzf - command-line fuzzy finder
Plug 'junegunn/fzf'

" LanguageTool
Plug 'vim-scripts/LanguageTool'

" The NERD tree - A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'
" Show git status in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" The NERD commenter - Plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" Surround - quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" File type icons to vim plugins - ALWAYS LAST PLUGIN TO INSTALL
Plug 'ryanoasis/vim-devicons'

" All of your Plugins must be added before the following line
call plug#end()
"==============================================================================


" Set Python3
let g:powerline_pycmd = 'py3'

" Set tmp directory
set directory=~/.vim/tmp//
" Maintain undo history between sessions
set undofile
" Location of tmp files for history of sessions
set undodir=~/.vim/tmp//

set number                              " Show line numbers
set relativenumber                      " Show relative line numbers

set mouse=a                             " Activate mouse support
set ruler                               " Print cursor position

set textwidth=0                         " Remove auto-wrapping
" Wraps at 72 characters with touch '#'
map # gwap

set history=50                          " Number of commands in history
set viminfo='20,\"50                    " Option of file ~/.viminfo
set backspace=2                         " Activate backspace key
set whichwrap=<,>,[,]                   " Allow switching between lines with arrows (left / right)
set scrolloff=1                         " Keeps always one line visible on the screen above the cursor
set showmatch                           " Display pair of parenthesis
set wildmode=list:full                  " Automatic auto completion
set nofoldenable                        " Remove folding

set vb                                  " Visual bell instead of beep
syntax on                               " Enable syntax coloration
set encoding=UTF-8                      " UTF-8 encoding
" Copy directly to system clipboard
set clipboard=unnamedplus


"==============================================================================
" TABS
set tabstop=4                           " Number of visual spaces per tab
set softtabstop=4                       " Number of spaces in tab when editing
set expandtab                           " tabs are spaces (spaces are not converted into tabs)
set shiftwidth=4


"==============================================================================
" COLORS
" Colorscheme (different for gvim)
if has('gui_running')                   " GVim colorscheme
    colorscheme jellybeans
else                                    " Vim colorscheme
    colorscheme molokai
endif

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
" GLOBAL MAPPING

" Workaround for Alt key in terminal
" TODO

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
" Alt mapping not working
nnoremap <silent><A-j>:set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k>:set paste<CR>m`O<Esc>``:set nopaste<CR>
" Switch between buffers with arrow or 'h' and 'l'
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
" fzf
map <C-b> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>


"==============================================================================
" TEMPLATES AND MAPPING FOR LANGUAGE


"===========================================================
" Bash
let g:BASH_AuthorName = 'Axel Fahy'
let g:BASH_AuthorRef = ''
let g:BASH_Email = 'axel@fahy.net'
let g:BASH_Company = ''


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
" Grammarous
" Check only in comments for certains files
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }


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
" Markdown
" Enable fenced code block syntax higlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']


"===========================================================
" Octave files
augroup filetypedetect
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END


"===========================================================
" Airline - automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" Powerline fonts with airline
" If using urxvt, needs to install compatible fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:airline#extensions#coc#enabled = 1


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


"==============================================================================
" CoC configuration
" If hidden is not set, TextEdit might fail
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000
set updatetime=300

" Don't give |ins-completion-menu| messages
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position
" Coc only does snippet and additional edit on confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
