""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Vundle                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf-8
scriptencoding utf-8

if has("win32")
    let $LANG='en'

    let g:haddock_docdir='C:/Program Files (x86)/Haskell Platform/2012.2.0.0/doc/html'
    let g:haddock_browser="C:/.TOOLS/Mozilla Firefox/firefox.exe"

    set rtp+=$VIM/vimfiles/bundle/vundle
    set rtp+=~/.vim/bundle/vundle/

    cd C:\markus
else
    let g:haddock_docdir='/usr/local/share/doc/ghc/html/'
    let g:haddock_browser="firefox"

    set rtp+=~/.vim/bundle/vundle/
endif
let no_selectbuf_maps=1

filetype off
call vundle#rc()

" Vundle
" To setup in new environment:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
Bundle 'gmarik/vundle'

" Syntax
Bundle 'avakhov/vim-yaml'
Bundle 'beyondmarc/glsl.vim'
Bundle 'beyondmarc/opengl.vim'
Bundle 'Matt-Stevens/vim-systemd-syntax'
Bundle 'Mediawiki.vim'

" Plugins
Bundle 'argtextobj.vim'
Bundle 'bling/vim-airline'
Bundle 'bufkill.vim'
Bundle 'chrisbra/csv.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'edkolev/tmuxline.vim'
Bundle 'edsono/vim-matchit'
Bundle 'honza/vim-snippets'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'YankRing.vim'

" Plugins using externals
" Prevent startup error messages
if has("python")
    Bundle 'SirVer/ultisnips'

    if v:version > 703 || (v:version == 703 && has('patch584'))
        if !has("win32")
            Bundle 'Valloric/YouCompleteMe'
        endif
    endif
endif

" Colorschemes
Bundle 'ciaranm/inkpot'
Bundle 'brendonrapp/smyck-vim'
Bundle 'jeremycw/darkspectrum'
Bundle 'lettuce.vim'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'matthewtodd/vim-twilight'
Bundle 'nanotech/jellybeans.vim'
Bundle 'peaksea'
Bundle 'sickill/vim-sunburst'
Bundle 'vim-scripts/synic.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Environment                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
if has("gui_running")
    colorscheme jellybeans

    set vb t_vb=
    set background=dark
    set guioptions=aegit
else
    if &t_Co != 256
        colorscheme synic
    else
        colorscheme jellybeans
    endif
endif

if has("gui_running")
    if has("win32")
        set gfn=Consolas:h11:cANSI
    else
        set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
    endif
endif

if has("win32")
    let localdir="%HOME%\\vim_local\\"
else
    let localdir="~/.vim_local/"
    set dir=/tmp//,~/tmp//,.
endif

if has("persistent_undo")
    if has("win32")
        set undodir=C:\Windows\Temp//
    else
        set undodir=~/.vim_local/undodir
    endif
    set undofile
endif
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
let maplocalleader=" "

syntax on

filetype on
filetype indent on
filetype plugin on

"""""""""""""
"  Airline  "
"""""""""""""
set laststatus=2

"""""""""""
"  Latex  "
"""""""""""
let g:LatexBox_quickfix=2
let g:LatexBox_latexmk_async=0
let g:LatexBox_latexmk_preview_continuously=0
let g:LatexBox_viewer="zathura"
let g:LatexBox_Folding=0

"""""""""""""""""
"  Haskellmode  "
"""""""""""""""""
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
" see top of file

"""""""""""""""""
"  vim-session  "
"""""""""""""""""
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

"""""""""""""""
"  Syntastic  "
"""""""""""""""
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '?'

"""""""""""""""""""
"  YouCompleteMe  "
"""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
set updatetime=1000

"""""""""""""""
"  UltiSnips  "
"""""""""""""""
"let g:UltiSnipsDontReverseSearchPath="1"
let g:UltiSnipsEditSplit="vertical"

" Avoid Clashes with YCM
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

""""""""""""""""
"  EasyMotion  "
""""""""""""""""
let g:EasyMotion_leader_key='<leader>'

""""""""""""
"  Ctrl-P  "
""""""""""""
let g:ctrlp_match_window='bottom,order:ttb,min:5,max:5'
let g:ctrlp_map='ä'
nnoremap <silent>ö :CtrlPBuffer<CR>

""""""""""""""
"  tmuxline  "
""""""""""""""
let g:tmuxline_powerline_separators = 0

""""""""""""""""""""""
"  multiple-cursors  "
""""""""""""""""""""""
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-b>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

""""""""""""""
"  YankRing  "
""""""""""""""
let g:yankring_replace_n_pkey='<C-O>'
let g:yankring_replace_n_nkey='<C-P>'

let g:yankring_history_dir=localdir

""""""""""""""
"  Markdown  "
""""""""""""""
au BufEnter *.md :se ft=markdown

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Mappings                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Bufexplorer
nnoremap <silent><leader>ö :SelectBuf<CR>

" Paste and Yank to System Register
nnoremap ü "+p
nnoremap Ü "+Y
vnoremap ü "+y
vnoremap Ü "+p
inoremap üü <C-r>*

" Replace without destroying the default register
vnoremap + "_dP

" Code Completion
inoremap <S-Space> <C-x><C-o><C-p>
inoremap <C-Space> <C-x><C-o><C-p>

" Folds
nnoremap + za

" Macro execution
nnoremap Q @

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Commands                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Interface                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
autocmd bufenter *.hs set cmdheight=1 " Rather aggressive fix for vim-haskell

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
if has("conceal")
    set conceallevel=2
    "set concealcursor=vin
    hi Conceal guibg=black guifg=white
    let g:tex_conceal="abdgm"
    let g:tex_flavor="latex"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    IDE                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=include/**
" To create systags run
" ctags -R -f $LOCALDIR/systags --c-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include
set tags+=./tags;/
let &tags.="," . localdir . "systags"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Local .vimrc                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so " . localdir . ".vimrc_local"
catch
endtry
