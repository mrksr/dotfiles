""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Vundle                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
scriptencoding utf-8

if has('nvim')
    runtime! python_setup.vim
endif

if has("win32")
    let $LANG='en'

    let g:haddock_docdir='C:/Program Files (x86)/Haskell Platform/2012.2.0.0/doc/html'
    let g:haddock_browser="C:/.TOOLS/Mozilla Firefox/firefox.exe"

    set rtp+=$VIM/vimfiles/bundle/noebundle.vim
    set rtp+=~/.vim/bundle/neobundle.vim

    cd C:\markus
else
    let g:haddock_docdir='/usr/local/share/doc/ghc/html/'
    let g:haddock_browser="firefox"

    set rtp+=~/.vim/bundle/neobundle.vim
endif
let no_selectbuf_maps=1

filetype off
call neobundle#begin(expand('~/.vim/bundle/'))

" Vundle
" To setup in new environment:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'linux' : 'make',
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\    },
\ }

" Languages
NeoBundle 'avakhov/vim-yaml'
NeoBundle 'beyondmarc/glsl.vim'
NeoBundle 'beyondmarc/opengl.vim'
" NeoBundle 'chrisbra/csv.vim'
" NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
" NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'Mediawiki.vim'
NeoBundle 'sheerun/vim-polyglot'

" Plugins
NeoBundle 'argtextobj.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'bufkill.vim'
NeoBundle 'DoxygenToolkit.vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'edsono/vim-matchit'
NeoBundle 'honza/vim-snippets'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'szw/vim-ctrlspace'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'floobits/floobits-neovim'

" Plugins using externals
" Prevent startup error messages
if has("python")
    NeoBundle 'guyzmo/notmuch-abook'
    NeoBundle 'SirVer/ultisnips'

    if v:version > 703 || (v:version == 703 && has('patch584'))
        if !has("win32") && !has("win32unix")
            NeoBundle 'Valloric/YouCompleteMe'
            NeoBundle 'bbchung/clighter' " Only need it with ycm
        endif
    endif
endif

" Colorschemes
NeoBundle 'ciaranm/inkpot'
NeoBundle 'Lokaltog/vim-distinguished'
NeoBundle 'matthewtodd/vim-twilight'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'sickill/vim-sunburst'
NeoBundle 'vim-scripts/synic.vim'

call neobundle#end()
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Environment                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
if has("gui_running")
    colorscheme jellybeans

    set vb t_vb=
    set background=dark
    set guioptions=agit
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
        set gfn=DeJaVu\ Sans\ Mono\ 11
    endif
endif

if has("win32")
    let localdir="$HOME/vim_local/"
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
" Ignore Preview for CtrlSpace
let g:airline_exclude_preview=1

"""""""""""
"  Latex  "
"""""""""""
let g:LatexBox_quickfix=2
let g:LatexBox_latexmk_async=0
let g:LatexBox_latexmk_preview_continuously=0
let g:LatexBox_viewer="zathura"
let g:LatexBox_Folding=0

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
                           \ 'passive_filetypes': ['tex', 'scala'] }
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '?'

"""""""""""""""""""
"  YouCompleteMe  "
"""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 1

nnoremap <leader>g :YcmCompleter GoToImprecise<CR>

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

"""""""""""
"  Unite  "
"""""""""""
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
\   'direction': 'botright',
\ })
let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'

nnoremap <silent><F3> :<C-u>Unite history/yank<CR>
nnoremap <silent>ä :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent>ö :<C-u>Unite buffer<CR>
nnoremap <silent>Ö :<C-u>Unite tag<CR>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

""""""""""""""
"  clighter  "
""""""""""""""
let g:clighter_cursor_hl_default = 0

""""""""""""""
"  Markdown  "
""""""""""""""
au BufEnter *.md :se ft=markdown

""""""""""""""""
"  easy-align  "
""""""""""""""""
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

"""""""""""""""
"  CtrlSpace  "
"""""""""""""""
hi link CtrlSpaceSelected Visual
hi link CtrlSpaceNormal   Normal
hi link CtrlSpaceStatus   Question
" hi CtrlSpaceFound

let g:ctrlspace_unicode_font=0
let g:ctrlspace_save_workspace_on_exit=1

""""""""""""""""
"  auto-ctags  "
""""""""""""""""
let g:auto_ctags=1
let g:auto_ctags_directory_list = ['.git', '.hg', '.svn']
let g:auto_ctags_tags_name = 'tags'
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes --fields+=l'

"""""""""""
"  sneak  "
"""""""""""
let g:sneak#s_next = 1
let g:sneak#streak = 1

"""""""""
"  csv  "
"""""""""
let g:csv_nomap_h = 1
let g:csv_nomap_l = 1

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

" Tab Movement
nnoremap <S-h> gT
nnoremap <S-l> gt
" In GVim
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
" In urxvt
nnoremap <Esc>1 1gt
nnoremap <Esc>2 2gt
nnoremap <Esc>3 3gt
nnoremap <Esc>4 4gt
nnoremap <Esc>5 5gt
nnoremap <Esc>6 6gt
nnoremap <Esc>7 7gt
nnoremap <Esc>8 8gt
nnoremap <Esc>9 9gt

" Use Perl Regexes
" nnoremap / /\v
" vnoremap / /\v

" Custom leader maps
nnoremap <silent><leader><Space> :CtrlSpace<CR>
nnoremap <silent><leader>j :nohl<CR>
nnoremap <silent><leader>k :nohl<CR>
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

" More convenient help browsing
au FileType help nnoremap <buffer> <CR> <C-]>
au FileType help nnoremap <buffer> <BS> <C-T>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Commands                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cd to current file
com! CD cd %:p:h
com! LCD lcd %:p:h

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
set autoread
set hidden
set number
set ruler

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
set spelllang=de,en,sv
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
set nojoinspaces

" Conceal
if has("conceal")
    set conceallevel=2
    "set concealcursor=vin
    hi! link Conceal Normal
    let g:tex_conceal="abgm"
    let g:tex_flavor="latex"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    IDE                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=include/**
" To create systags run
" ctags -R -f $LOCALDIR/systags --c-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include
set tags+=.git/tags;,.hg/tags;,.svn/tags;
let &tags.="," . localdir . "systags"
let g:load_doxygen_syntax=1

augroup commentstrings
    autocmd FileType cmake setlocal commentstring=#%s
augroup END

augroup todostrings
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(BUG|TODO|FIXME)(\(.*\))?:?', -1)
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(NOTE)(\(.*\))?:?', -2)
augroup END

" Remove special case '#'
inoremap # X#
set cinkeys-=0#
set indentkeys-=0#

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Local .vimrc                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so " . localdir . ".vimrc_local"
catch
endtry
