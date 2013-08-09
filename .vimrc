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
Bundle 'argtextobj.vim'
Bundle 'avakhov/vim-yaml'
Bundle 'beyondmarc/opengl.vim'
Bundle 'bufkill.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'edsono/vim-matchit'
Bundle 'godlygeek/tabular.git'
Bundle 'jcf/vim-latex'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'mattn/zencoding-vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'Rename'
Bundle 'rygwdn/vim-conque'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'SelectBuf'
Bundle 'SirVer/ultisnips'
Bundle 'TagHighlight'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/YouCompleteMe'
Bundle 'xolox/vim-misc'
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

" Font
if has("gui_running")
    if has("win32")
        set gfn=Consolas:h11:cANSI
    else
        set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
    endif
endif

if has("win32")
    let localdir="%HOME%\\vim_local\\"
    set undodir=C:\Windows\Temp//
else
    let localdir="~/.vim_local/"
    set dir=/tmp//,~/tmp//,.
    set undodir=~/.vim_local/undodir
endif
" localdir is later used for the local vimrc import

set undofile
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
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

" Disable everything we want UltiSnips to handle
let g:Imap_UsePlaceHolders=0
let g:SmartKeyBS=0
let g:SmartKeyQuote=0
let g:Tex_EnvironmentMaps=0
let g:Tex_FontMaps=0
let g:Tex_SectionMaps=0

" nicer conceal
" this is not part of the vim-latex plugin.
let g:tex_conceal="adgm"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Haskellmode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
" see top of file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-session
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions+=buffers
set sessionoptions-=blank
set sessionoptions-=help
set sessionoptions-=localoptions
set sessionoptions-=options
set sessionoptions-=resize
set sessionoptions-=winpos
set sessionoptions-=winsize
let g:session_autosave='yes'
let g:session_autosave_periodic=5
let g:session_autoload='no'

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
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
set updatetime=1000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsDontReverseSearchPath="1"
let g:UltiSnipsEditSplit="vertical"

" Avoid Clashes with YCM
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_leader_key='<leader>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl P
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_match_window='bottom,order:ttb,min:5,max:5'
let g:ctrlp_map='<leader>m'
nnoremap <silent><leader>ö :CtrlPBuffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap ß <C-W>=

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
nnoremap <silent><C-right> :bn<cr>
nnoremap <silent><C-left> :bp<cr>

" Function Keys
nnoremap <silent><F3> :YRShow<CR>
inoremap <silent><F3> <ESC>:YRShow<CR>
vnoremap <silent><F3> c<ESC>:YRShow<CR>
nnoremap <silent><F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <silent><F8> :TlistToggle<CR>
nnoremap <silent><F9> :NERDTreeToggle<CR><C-W>l

" Use Perl Regexes
nnoremap / /\v
vnoremap / /\v

" Custom leader maps
nnoremap <silent><leader><Space> :nohl<CR>
" Spell Checking
nnoremap <silent><leader>ss :setlocal spell!<cr>
nnoremap <silent><leader>sn ]s
nnoremap <silent><leader>sp [s
nnoremap <silent><leader>sa zg
nnoremap <silent><leader>s? z=
nnoremap <silent><leader>sc z=
" Remove trailing whitespace
nnoremap <silent><leader>i :%s/\s\+$//<CR>:let @/=''<CR>
vnoremap <silent><leader>i :'<,'>s/\s\+$//<CR>:let @/=''<CR>
" Remove blank lines
nnoremap <silent><leader>p :g/^$/d<CR>:let @/=''<CR>
vnoremap <silent><leader>p :g/^$/d<CR>:let @/=''<CR>
" Collapse lines
nnoremap <silent><leader>o Goj<Esc>:g/^$/.,/./-j<CR>Gdd:let @/=''<CR>
vnoremap <silent><leader>o :g/^$/.,/./-j<CR>:let @/=''<CR>
" CTags
"map <leader>t :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

" Space scrolling
"nnoremap <Space> <C-f>
"nnoremap <S-Space> <C-b>

" Paste and Yank to System Register
nnoremap ü "+p
nnoremap Ü "+Y
vnoremap ü "+y
vnoremap Ü "+p
inoremap üü <C-r>*

" Replace without destroying the default register
vnoremap r "_dP

" Bufexplorer
nnoremap <silent>ö :SelectBuf<CR>

" Code Completion
inoremap <S-Space> <C-x><C-o><C-p>
inoremap <C-Space> <C-x><C-o><C-p>

" Remap new Leader Key
nnoremap - ,
nnoremap _ ;

" Folds
nnoremap + za

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cd to current file
com! CD cd %:p:h

com! -nargs=* -bang S OpenSession<bang> <args>

" create .clang_complete file
com! CLmake make CC='~/.vim/bundle/clang_complete/bin/cc_args.py gcc' CXX='~/.vim/bundle/clang_complete/bin/cc_args.py g++' -B

" typo commands
com! -bang Q q<bang>
com! -bang Qa qa<bang>
com! -bang QA qa<bang>

" write again with root permissions
cmap w!! w !sudo tee %

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
set completeopt=menuone,longest
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
set matchtime=5

" No sound on errors
set noerrorbells
set visualbell
set t_vb=
autocmd GUIEnter * set visualbell t_vb=
set timeoutlen=500

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

" Conceal
set conceallevel=2
"set concealcursor=vin
hi Conceal guibg=black guifg=white

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IDE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=include/**
" To create systags run
" ctags -R -f $LOCALDIR/systags --c-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include
set tags+=./tags;/
let &tags.="," . localdir . "systags"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so " . localdir . ".vimrc_local"
catch
endtry
