function! mrksr#after() abort

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Environment                             {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
"  Markdown  "
""""""""""""""
au BufEnter *.md :se ft=markdown

"""""""""""""
"  Tabline  "
"""""""""""""
set showtabline=0

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
"  Neomake  "
"""""""""""""
let g:neomake_tex_enabled_makers = []
let g:neomake_python_enabled_makers = ['python', 'pylint']

"""""""""""""""
"  Neoformat  "
"""""""""""""""
let g:neoformat_enabled_python = [
      \ 'black', 'isort',
      \ 'yapf', 'autopep8',
      \ 'pydefv', 'docformatter',
      \ 'pyment',
      \ ]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Mappings                              {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
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

" Paste and Yank to System Register
nnoremap ü "+p
nnoremap Ü "+Y
vnoremap ü "+y
vnoremap Ü "+p
inoremap üü <C-r>+

" Macro execution
nnoremap Q q

" More convenient help browsing
au FileType help nnoremap <buffer> <CR> <C-]>
au FileType help nnoremap <buffer> <BS> <C-T>


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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Interface                              {{{1"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
let @/=''
set ignorecase
set smartcase
set gdefault
set hlsearch
set incsearch

" Show tab-characters
set list
set listchars=tab:»·,trail:·

" Spell checking
set spelllang=de,en
set nospell

" Lines
set wrap
set linebreak
set display=lastline
set nojoinspaces

" Folds
set foldlevel=1
set foldnestmax=2
set nofoldenable
augroup folds
    autocmd FileType tex setl foldenable foldlevel=0 foldnestmax=1
    autocmd BufRead,BufNewFile *.c,*.cpp,*.cc setl foldlevel=0 foldnestmax=1
augroup END

" TODO
augroup todostrings
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(BUG|TODO|FIXME)(\(.{-}\))?:?', -1)
    autocmd Syntax * call matchadd('Todo', '\v\W\zs(NOTE)(\(.{-}\))?:?', -2)
augroup END

" Remove special case '#' in C code
inoremap # X#
set cinkeys-=0#
set indentkeys-=0#

endfunction
