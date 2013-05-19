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

filetype off
call vundle#rc()

" Vundle
" To setup in new environment:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
Bundle 'gmarik/vundle'

" Libs
Bundle 'L9'
Bundle 'vim-scripts/genutils'

" Plugins
Bundle 'Align'
Bundle 'avakhov/vim-yaml'
Bundle 'beyondmarc/opengl.vim'
Bundle 'bufkill.vim'
Bundle 'Cpp11-Syntax-Support'
Bundle 'derekwyatt/vim-scala'
Bundle 'edsono/vim-matchit'
Bundle 'ervandew/supertab'
Bundle 'JazzCore/neocomplcache-ultisnips'
Bundle 'jcf/vim-latex'
Bundle 'Lokaltog/vim-powerline'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'mattn/zencoding-vim'
Bundle 'mortice/taglist.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'rygwdn/vim-conque'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'SelectBuf'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'SirVer/ultisnips'
Bundle 'TagHighlight'
Bundle 'tpope/vim-surround'
Bundle 'ujihisa/neco-ghc'
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
    if &t_Co != 256
        colorscheme synic
    else
        colorscheme distinguished
    endif
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
    au VimEnter * call IMAP('EFE', "\\begin{frame}\<CR>\\frametitle{<++>}\<CR>\\setbeamercovered{dynamic}\<CR><++>\<CR>\\end{frame}<++>", 'tex')
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
" clang_complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set conceallevel=2
set concealcursor=vin
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_complete_copen=1
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='ultisnips'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplcache
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

let g:necoghc_enable_detailed_browse = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType='<c-x><c-u>'

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
map <silent><leader>l :se nolist!<CR>
map <silent><leader>n :sign unplace *<CR>
map <silent><leader>y :SyntasticCheck<CR>
map <silent><leader>z :MRU<CR>
map <silent><leader>cd :CD<CR>
" Spell Checking
map <silent><leader>ss :setlocal spell!<cr>
map <silent><leader>sn ]s
map <silent><leader>sp [s
map <silent><leader>sa zg
map <silent><leader>s? z=
map <silent><leader>sc z=
" Align
nnoremap <leader>i :Align<Space>
vnoremap <leader>i :Align<Space>
nnoremap <leader>I :Align!<Space>
vnoremap <leader>I :Align!<Space>
" Remove trailing whitespace
nnoremap <silent><leader>w :%s/\s\+$//<CR>:let @/=''<CR>
vnoremap <silent><leader>w :'<,'>s/\s\+$//<CR>:let @/=''<CR>
" Remove blank lines
nnoremap <silent><leader>e :g/^$/d<CR>:let @/=''<CR>
vnoremap <silent><leader>e :g/^$/d<CR>:let @/=''<CR>
" Collapse lines
nnoremap <silent><leader>r Goj<Esc>:g/^$/.,/./-j<CR>Gdd:let @/=''<CR>
vnoremap <silent><leader>r :g/^$/.,/./-j<CR>:let @/=''<CR>
" CTags
map <leader>t :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

" Space scrolling
nnoremap <Space> <C-f>
nnoremap <S-Space> <C-b>
"inoremap <C-Space> <C-x><C-o>

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
com! Q q
com! Qa qa

" create .clang_complete file
com! CLmake make CC='~/.vim/bundle/clang_complete/bin/cc_args.py gcc' CXX='~/.vim/bundle/clang_complete/bin/cc_args.py g++' -B

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
" IDE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" local include path
set path+=include

" ctags files
" To create systags run
" ctags -R -f $LOCALDIR/systags --c-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include
set tags+=./tags;/
let &tags.=",".localdir."systags"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so " . localdir . ".vimrc_local"
catch
endtry
