" vim: fdm=marker fdl=0 fen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Bundles                               {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
scriptencoding utf-8

if has('nvim')
    runtime! python_setup.vim
endif

if has("win32")
    let $LANG='en'
endif

let s:freshInstall = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    let s:freshInstall = 1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * Plugestall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle/')
" Languages
Plug 'avakhov/vim-yaml'
Plug 'beyondmarc/glsl.vim'
Plug 'beyondmarc/opengl.vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'Mediawiki.vim'
Plug 'sheerun/vim-polyglot'

" Plugins
Plug 'argtextobj.vim'
Plug 'DoxygenToolkit.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'edsono/vim-matchit'
Plug 'floobits/floobits-neovim'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'mhinz/vim-sayonara'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'soramugi/auto-ctags.vim'
Plug 'svermeulen/vim-easyclip'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tsukkee/unite-tag'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugins using externals
" Prevent startup error messages
if has("python")
    Plug 'guyzmo/notmuch-abook'
    Plug 'SirVer/ultisnips'

    if v:version > 703 || (v:version == 703 && has('patch584'))
        if !has("win32") && !has("win32unix")
            Plug 'Valloric/YouCompleteMe'
            " Plug 'bbchung/clighter' " Only need it with ycm
        endif
    endif
endif

" Colorschemes
Plug 'ciaranm/inkpot'
Plug 'Lokaltog/vim-distinguished'
Plug 'matthewtodd/vim-twilight'
Plug 'nanotech/jellybeans.vim'
Plug 'sickill/vim-sunburst'
Plug 'vim-scripts/synic.vim'
Plug 'chriskempson/base16-vim'
call plug#end()

if s:freshInstall
    PlugInstall
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Environment                             {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
if has("gui_running")
    colorscheme base16-tomorrow

    set vb t_vb=
    set background=dark
    set guioptions=agit
else
    if &t_Co != 256
        let base16colorspace=16
        colorscheme base16-tomorrow
    else
        let base16colorspace=256
        colorscheme base16-tomorrow
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
"                                  Plugins                               {{{1"
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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline_theme='tomorrow'

"""""""""""
"  Latex  "
"""""""""""
let g:LatexBox_quickfix = 2
let g:LatexBox_latexmk_async = 0
let g:LatexBox_latexmk_preview_continuously = 0
let g:LatexBox_viewer = "zathura"
let g:LatexBox_custom_indent = 1
let g:LatexBox_Folding = 1
let g:LatexBox_fold_automatic = 0
let g:LatexBox_fold_envs = 0
let g:LatexBox_fold_envs_force = [
    \ 'frame',
    \ 'abstract',
    \ 'algorithm',
    \ 'figure',
    \ 'table',
    \ 'listing',
    \ 'figure*',
    \ 'table*',
    \ 'listing*',
    \ 'tikzpicture'
    \]

" Calculate folds on open
autocmd FileType tex LatexFold

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

"""""""""""""
"  Signify  "
"""""""""""""
let g:signify_update_on_bufenter = 0
let g:signify_update_on_focusgained = 1

nnoremap <leader>h :SignifyToggleHighlight<CR>
nmap <leader>j <plug>(signify-next-hunk)
nmap <leader>k <plug>(signify-prev-hunk)

"""""""""""""""
"  UltiSnips  "
"""""""""""""""
"let g:UltiSnipsDontReverseSearchPath="1"
let g:UltiSnipsEditSplit="vertical"

" Avoid Clashes with YCM
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

""""""""""""""
"  tmuxline  "
""""""""""""""
let g:tmuxline_powerline_separators = 0

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
nnoremap <silent>Ä :<C-u>Unite outline<CR>
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
let g:ClighterOccurrences = 0
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

""""""""""""""
"  startify  "
""""""""""""""
let g:startify_list_order = [
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ['   LRU:'],
  \ 'files',
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ]

let g:startify_bookmarks = ['~/.vimrc', '~/dotfiles']

let g:startify_custom_header = [
      \ '           _',
      \ '          (_)',
      \ '    __   ___ _ __ ___',
      \ '    \ \ / / | ´_ ` _ \',
      \ '     \ V /| | | | | | |_',
      \ '      \_/ |_|_| |_| |_(_)',
      \ '',
      \ '']

let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 8

""""""""""""""""
"  auto-ctags  "
""""""""""""""""
let g:auto_ctags=1
let g:auto_ctags_directory_list = ['.git', '.hg', '.svn']
let g:auto_ctags_tags_name = 'tags'
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes --fields+=l'

"""""""""
"  csv  "
"""""""""
let g:csv_nomap_h = 1
let g:csv_nomap_l = 1

""""""""""""""
"  EasyClip  "
""""""""""""""
let g:EasyClipShareYanks = 1
let g:EasyClipShareYanksFile = "easyclip"
let g:EasyClipShareYanksDirectory = localdir

nnoremap Y :EasyClipBeforeYank<cr>yy:EasyClipOnYanksChanged<cr>

"""""""""""""""""""
"  expand-region  "
"""""""""""""""""""
map K <Plug>(expand_region_expand)
" map J <Plug>(expand_region_shrink)

""""""""""""""
"  sayonara  "
""""""""""""""
com! -bang BD Sayonara<bang>

"""""""""""""""""""""""
"  vim-indent-guides  "
"""""""""""""""""""""""
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Mappings                              {{{1"
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
nnoremap <silent><leader><leader> :nohl<CR>
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
nnoremap <leader>f za
nnoremap <leader>F zMzvzz

" Macro execution
nnoremap Q @

" More convenient help browsing
au FileType help nnoremap <buffer> <CR> <C-]>
au FileType help nnoremap <buffer> <BS> <C-T>

" Nvim bindings
if has('nvim')
    tnoremap <Esc><Esc> <C-\><C-n>
    nnoremap <C-j> <C-\><C-n><C-W>j
    nnoremap <C-k> <C-\><C-n><C-W>k
    nnoremap <C-h> <C-\><C-n><C-W>h
    nnoremap <C-l> <C-\><C-n><C-W>l
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Commands                              {{{1"
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
"                                 Interface                              {{{1"
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

" Folds
set foldmethod=syntax
set foldlevel=1
set foldnestmax=2
set nofoldenable
augroup folds
    autocmd FileType tex setl foldlevel=0 foldnestmax=1 foldenable
    autocmd BufRead,BufNewFile *.c,*.cpp,*.cc setl foldlevel=0 foldnestmax=1
augroup END

" Conceal
if has("conceal")
    set conceallevel=2
    "set concealcursor=vin
    hi! link Conceal Normal
    let g:tex_conceal="abgm"
    let g:tex_flavor="latex"
endif

" Sessions
set sessionoptions+=buffers
set sessionoptions+=tabpages
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=blank
set sessionoptions-=help
set sessionoptions-=localoptions
set sessionoptions-=options
set sessionoptions-=resize
set sessionoptions-=winpos
set sessionoptions-=winsize

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    IDE                                 {{{1"
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
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(BUG|TODO|FIXME)(\(.{-}\))?:?', -1)
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(NOTE)(\(.{-}\))?:?', -2)
augroup END

" Remove special case '#'
inoremap # X#
set cinkeys-=0#
set indentkeys-=0#

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Local .vimrc                            {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so " . localdir . ".vimrc_local"
catch
endtry
