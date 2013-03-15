"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

let g:Powerline_symbols='compatible'
if has("win32")
    let $LANG='en'

    let g:haddock_docdir='C:/Program Files (x86)/Haskell Platform/2012.2.0.0/doc/html'
    let g:haddock_browser="C:/.TOOLS/Mozilla Firefox/firefox.exe"

    set rtp+=$VIM/vimfiles/bundle/vundle
else
    let g:haddock_docdir='/usr/local/share/doc/ghc/html/'
    let g:haddock_browser="firefox"
    if has('gui_running')
        let g:Powerline_symbols='fancy'
    endif

    set rtp+=~/.vim/bundle/vundle/
endif
let no_selectbuf_maps=1

call vundle#rc()

" Vundle
Bundle 'gmarik/vundle'

" Libs
Bundle 'L9'
Bundle 'vim-scripts/genutils'

" Plugins
Bundle 'Align'
Bundle 'avakhov/vim-yaml'
Bundle 'bufkill.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'edsono/vim-matchit'
Bundle 'FuzzyFinder'
Bundle 'jcf/vim-latex'
Bundle 'Lokaltog/vim-powerline'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'mattn/zencoding-vim'
Bundle 'mru.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'SelectBuf'
Bundle 'ShowMarks'
Bundle 'TagHighlight'
Bundle 'tpope/vim-surround'
Bundle 'wincent/Command-T'
Bundle 'xolox/vim-session'
Bundle 'YankRing.vim'

" Colorschemes
Bundle 'Lokaltog/vim-distinguished'
Bundle 'matthewtodd/vim-twilight'
Bundle 'sickill/vim-sunburst'
Bundle 'vim-scripts/synic.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment specifics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
if has("gui_running")
    colorscheme distinguished

    set gfn=Consolas\ 12
    set vb t_vb=
    set background=dark
    set guioptions=aegit

    " Close vim if NERDTree is the last buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
else
    colorscheme synic
endif

if has("win32")
    let localdir="%HOME%\\vim_local\\"
    set undodir=C:\Windows\Temp//
    cd C:\markus\repos
else
    let localdir="~/.vim_local/"
    let &undodir=localdir."undodir//"
    set dir=/tmp//,~/tmp//,.
endif

" localdir is later used for the local vimrc import

set undofile
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
scriptencoding utf-8
set encoding=utf-8

syntax on

filetype on
filetype indent on
filetype plugin on

" Powerline
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-latex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set grepprg="grep -nH $*"

let g:tex_flavor='latex'
let g:tex_indent_brace=1
let g:Tex_SmartKeyQuote=0
let g:Tex_CompileRule_pdf='pdflatex -synctex=1 -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
let g:Tex_GotoError=1
let g:Tex_IgnoreLevel=7
let g:Tex_FoldedEnvironments='verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage,frame'
augroup MyIMAPs
    au!
    au VimEnter * call IMAP('EFE', "\\begin{frame}\<CR>\\setbeamercovered{dynamic}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}<++>", 'tex')
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Haskellmode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" see top of file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Showmarks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:showmarks_ignore_type='hqpm'
let g:showmarks_include='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:showmarks_enable=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-session
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=help
set sessionoptions-=options
set sessionoptions-=resize
set sessionoptions+=buffers
let g:session_autosave=0
let g:session_autoload=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>A :Align<Space>
vnoremap <leader>A :Align<Space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-T
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CommandTMaxFiles=10000
let g:CommandTMaxDepth=15
let g:CommandTMaxCachedDirectories=1
let g:CommandTAlwaysShowDotFiles=0
let g:CommandTMaxHeight=5

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['tex'] }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map ß <C-W>=

" Move by wrapped line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
inoremap <silent><up> <C-o>gk
inoremap <silent><down> <C-o>gj

" Use arrows to move between buffers
map <silent><C-right> :bn<cr>
map <silent><C-left> :bp<cr>

" Jump to marks
map ä '
map Ä `

" Function Keys
map <silent><F3> :YRShow<CR>
imap <silent><F3> <ESC>:YRShow<CR>
map <silent><F8> :TlistToggle<CR>
map <silent><F9> :NERDTreeToggle<CR><C-W>l

" Use Perl Regexes
nnoremap / /\v
vnoremap / /\v

" Custom leader maps
map <silent><leader><Space> :nohl<CR>
map <silent><leader>s :se nolist!<CR>
map <silent><leader>n :sign unplace *<CR>
map <silent><leader>c :SyntasticCheck<CR>
map <silent><leader>z :MRU<CR>
" Remove trailing whitespace
nnoremap <silent><leader>w :%s/\s\+$//<CR>:let @/=''<CR>
" Collapse lines
nnoremap <silent><leader>r Goj<Esc>:g/^$/.,/./-j<CR>Gdd:let @/=''<CR>
nnoremap <silent><leader>e GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd:let @/=''<CR>
vnoremap <silent><leader>r :g/^$/.,/./-j<CR>:let @/=''<CR>
vnoremap <silent><leader>e :g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>:let @/=''<CR>

" Space scrolling
"nnoremap <Space> <C-d>
nnoremap <S-Space> <C-b>
inoremap <C-Space> <C-x><C-o>

" Paste and Yank to System Register
nnoremap ü "+p
nnoremap Ü "+Y
vnoremap ü "+y
vnoremap Ü "+p
inoremap üü <C-r>*

" Folds
nnoremap - za

" Bufexplorer
nnoremap <silent>ö :SelectBuf<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cd to current file
com! CD cd %:p:h

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use mouse when possible
set mouse=a

" command history size
set history=1000

" Buffers
" set autochdir
set autoread
set hidden
set number
set ruler
autocmd bufenter * set cmdheight=1 " Rather aggressive fix for vim-haskell

" Commands
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,longest,preview
set cmdheight=1

" Navigation
set backspace=eol,start,indent
set whichwrap+=<,>,h,l,b,s
set virtualedit=block
set scrolloff=0

" Search
let @/=''
set ignorecase
set smartcase
set gdefault
set hlsearch
set incsearch
set lazyredraw
set showmatch
set mat=5

" No sound on errors
set noerrorbells
set visualbell
set t_vb=
autocmd GUIEnter * set visualbell t_vb=
set tm=500

" Show tab-characters
set list
set listchars=tab:»·,trail:·

" Spell checking
set spelllang=de,en
set nospell

" Tabs
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" Lines
set autoindent
set smartindent
set wrap
set linebreak
set display=lastline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so" . localdir . ".vimrc_local"
catch
endtry
