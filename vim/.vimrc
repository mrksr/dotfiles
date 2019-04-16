" vim: fdm=marker fen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Bundles                               {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
scriptencoding utf-8

if has("win32")
    let $LANG='en'
endif

if has("win32")
    let s:localdir=expand("$HOME/vim_local/")
else
    let s:localdir="~/.vim_local/"
    set dir=/tmp//,~/tmp//,.
endif

if has('nvim')
    let s:plugPath = '~/.config/nvim/autoload/plug.vim'
    let s:bundlePath = '~/.config/nvim/bundle/'

    let s:nerdFile = s:localdir . "with_nerd*"
    let s:fancyFile = s:localdir . "with_fancy*"
else
    let s:plugPath = '~/.vim/autoload/plug.vim'
    let s:bundlePath = '~/.vim/bundle/'

    let s:nerdFile = s:localdir . "with_nerd"
    let s:fancyFile = s:localdir . "with_fancy"
endif

if empty(glob(s:fancyFile))
    let s:fancyPlugins = 0
else
    let s:fancyPlugins = 1
endif

if empty(glob(s:nerdFile))
    let s:nerdFonts = 0
else
    let s:nerdFonts = 1
endif

let s:freshInstall = 0
if empty(glob(s:plugPath))
    let s:freshInstall = 1
    execute '!curl -fLo ' . s:plugPath . ' --create-dirs ' .
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(s:bundlePath)
" Languages
Plug 'lervag/vimtex'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'stephpy/vim-yaml'
Plug 'tweekmonster/braceless.vim'
Plug 'tweekmonster/impsort.vim'
Plug 'Vimjas/vim-python-pep8-indent'

" Plugins
Plug 'benjifisher/matchit.zip'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'fisadev/vim-isort'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'Konfekt/FastFold'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-sayonara'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'SirVer/ultisnips'
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'zenbro/mirror.vim'

if s:fancyPlugins
    " Plug 'floobits/floobits-neovim'

    function! InstallCoqDeps(info)
        if a:info.status == 'installed' || a:info.force
            call coc#util#install()

            let extensions = [
                        \ 'coc-pyls',
                        \ 'coc-ultisnips',
                        \ 'coc-vimtex',
                        \ ]
            for ext in extensions
                call coc#add_extension(ext)
            endfor
        endif
    endfunction
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': function('InstallCoqDeps')}
endif

" Colorschemes
" NOTE(mrksr): See https://github.com/chriskempson/base16-vim/issues/197
function FixupBase16(info)
    let l:sedCommand = 'sed -i ''/Base16hi/\! s/a:\(attr\|guisp\)/l:\1/g'''
    exec '!' . l:sedCommand . ' ' . s:bundlePath . 'base16-vim/colors/*.vim'
endfunction
Plug 'chriskempson/base16-vim', { 'do': function('FixupBase16') }
call plug#end()

if s:freshInstall
    echo "Installing Plugins..."
    PlugInstall
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Environment                             {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("nvim")
    set termguicolors
    set title
endif

set background=dark
if has("gui_running")
    let base16colorspace=256
    colorscheme base16-railscasts

    set vb t_vb=
    set background=dark
    set guioptions=agit
else
    if &t_Co != 256
        let base16colorspace=16
        colorscheme base16-railscasts
    else
        let base16colorspace=256
        colorscheme base16-railscasts
    endif
endif

if has("gui_running")
    if has("win32")
        set gfn=Consolas:h11:cANSI
    else
        set gfn=DeJaVu\ Sans\ Mono\ 11
    endif
endif

if has("persistent_undo")
    set undodir=~/.vim_local/undodir
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


""""""""""""""
"  polyglot  "
""""""""""""""
let g:polyglot_disabled = [
    \ "latex"
    \]


"""""""""""""
"  Airline  "
"""""""""""""
set laststatus=2
let g:airline_theme='base16'

if s:nerdFonts
    let g:airline_powerline_fonts = 1
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_tab_type = 0


""""""""""""""
"  tmuxline  "
""""""""""""""
if s:nerdFonts
    let g:tmuxline_powerline_separators = 1
else
    let g:tmuxline_powerline_separators = 0
endif


"""""""""""
"  Latex  "
"""""""""""
let g:tex_fast = "Mp"
let g:tex_no_error = 1
let g:tex_conceal = ""

let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_ignored_warnings = [
    \ 'Underfull',
    \ 'Overfull',
    \ 'specifier changed to',
    \ ]


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
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger='<c-f>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" Workaround for backward trigger
inoremap <c-x><c-k> <c-x><c-k>

" Workaround slowdown in neovim
if has('nvim')
    augroup ultisnips_no_auto_expansion
        au!
        au VimEnter * au! UltiSnips_AutoTrigger
    augroup END
endif


""""""""""""""
"  Markdown  "
""""""""""""""
au BufEnter *.md :se ft=markdown


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
      \ '']

let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 8


""""""""""""""
"  EasyClip  "
""""""""""""""
let g:EasyClipShareYanks = 1
let g:EasyClipShareYanksFile = "easyclip"
let g:EasyClipShareYanksDirectory = s:localdir

nnoremap Y :EasyClipBeforeYank<cr>yy:EasyClipOnYanksChanged<cr>


""""""""""""""
"  sayonara  "
""""""""""""""
com! -bang BD Sayonara<bang>


""""""""""""""""
"  completion  "
""""""""""""""""
if s:fancyPlugins
    set updatetime=300
    set pumheight=5

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    function! s:show_documentation()
        if &filetype == 'vim'
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <silent><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <silent><expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"

    inoremap <silent><expr> <S-Space> coc#refresh()
    inoremap <silent><expr> <C-Space> coc#refresh()

    nnoremap <silent><leader>cd <Plug>(coc-definition)
    nnoremap <silent><leader>ce <Plug>(coc-references)
    nnoremap <silent><leader>cf <Plug>(coc-format-selected)
    nnoremap <silent><leader>ci <Plug>(coc-implementation)
    nnoremap <silent><leader>cn <Plug>(coc-rename)
    nnoremap <silent><leader>cr :call <SID>show_documentation()<CR>
    nnoremap <silent><leader>ct <Plug>(coc-type-definition)
    nnoremap <silent><leader>cx <Plug>(coc-fix-current)

    vnoremap <silent><leader>cf <Plug>(coc-format-selected)

    augroup coc_config
        autocmd!

        " Update signature help on jump placeholder
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        autocmd CursorHoldI,CursorMovedI * call CocActionAsync('showSignatureHelp')
    augroup end
endif


"""""""""
"  fzf  "
"""""""""
command! FasdCD call fzf#run({
\  'source': 'fasd -Rdl',
\  'sink': 'cd',
\  'down': '40%',
\ })


"""""""""""""
"  dirvish  "
"""""""""""""
augroup dirvish_config
    autocmd!

    " Backspace to go up a level
    autocmd FileType dirvish nmap <silent><buffer> <BS> <Plug>(dirvish_up)
    autocmd FileType dirvish xmap <silent><buffer> <BS> <Plug>(dirvish_up)

    " gh to hide hidden files
    autocmd FileType dirvish nnoremap <silent><buffer>
                \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END


"""""""""""""""""""
"  Braceless.vim  "
"""""""""""""""""""
augroup braceless_config
    autocmd!

    autocmd FileType python BracelessEnable +fold
    autocmd FileType python set foldmethod=indent
augroup END


""""""""""
"  Rust  "
""""""""""
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Mappings                              {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""
"  Basic  "
"""""""""""
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

" Paste and Yank to System Register
nnoremap ü "+p
nnoremap Ü "+Y
vnoremap ü "+y
vnoremap Ü "+p
inoremap üü <C-r>*

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


"""""""""""""""""
"  Leader maps  "
"""""""""""""""""
" We use spacemacs-style chords
nnoremap <silent><leader>qq ZZ

" Search
nnoremap <silent><leader><leader> :nohl<CR>
nnoremap <silent><leader>sc :nohl<CR>

" Spell Checking
nnoremap <silent><leader>Ss :setlocal spell!<cr>
nnoremap <silent><leader>Sn ]s
nnoremap <silent><leader>Sp [s
nnoremap <silent><leader>Sa zg
nnoremap <silent><leader>Sc z=
nnoremap <silent><leader>S? z=
nnoremap <silent><leader>Sf 1z=
nnoremap <silent><leader>SF 1z=

" Files
nnoremap <silent><leader>fed :e $MYVIMRC<cr>
nnoremap <silent><leader>fs :w<cr>
" Remove trailing whitespace
nnoremap <silent><leader>fw :%s/\s\+$//<CR>:let @/=''<CR>
vnoremap <silent><leader>fw :'<,'>s/\s\+$//<CR>:let @/=''<CR>
" Remove blank lines
nnoremap <silent><leader>fL :g/^$/d<CR>:let @/=''<CR>
vnoremap <silent><leader>fL :g/^$/d<CR>:let @/=''<CR>
" Collapse lines
nnoremap <silent><leader>fl Goj<Esc>:g/^$/.,/./-j<CR>Gdd:let @/=''<CR>
vnoremap <silent><leader>fl :g/^$/.,/./-j<CR>:let @/=''<CR>

" Folds
nnoremap <leader>fa za
nnoremap <leader>fr zr
nnoremap <leader>fR zR
nnoremap <leader>fC zMzvzz
nnoremap <leader>fc zm
nnoremap <leader>fo zO
nnoremap <leader>fO zo

" Search
nnoremap <silent><leader>ff :<C-u>Files<CR>
nnoremap <silent><leader>pf :<C-u>GFiles<CR>

nnoremap <silent><leader>pp :<C-u>FasdCD<CR>
nnoremap <silent><leader>ps :<C-u>Rg<CR>

nnoremap <silent><leader>bb :<C-u>Buffers<CR>
nnoremap <silent><leader>br :<C-u>History<CR>
nnoremap <silent><leader>bs :<C-u>Lines<CR>

nnoremap <silent><leader>ss :<C-u>BLines<CR>
nnoremap <silent><leader>sj :<C-u>Tags<CR>

" Session
nnoremap <silent><leader>pw :ToggleWorkspace<CR>

" Language specific
nnoremap <silent><leader>fi :Isort<CR>


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
set history=10000

" Buffers
set autoread
set hidden
set number
set ruler

" Commands
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noinsert,noselect
set cmdheight=1
set noshowmode
set shortmess+=c

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
set foldlevel=1
set foldnestmax=2
set nofoldenable
augroup folds
    autocmd FileType tex setl foldlevel=0 foldnestmax=1
    autocmd BufRead,BufNewFile *.c,*.cpp,*.cc setl foldlevel=0 foldnestmax=1
augroup END

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


augroup todostrings
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(BUG|TODO|FIXME)(\(.{-}\))?:?', -1)
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(NOTE)(\(.{-}\))?:?', -2)
augroup END

" Remove special case '#' in C code
inoremap # X#
set cinkeys-=0#
set indentkeys-=0#


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Local .vimrc                            {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    exec ":so " . s:localdir . "vimrc"
catch
endtry
