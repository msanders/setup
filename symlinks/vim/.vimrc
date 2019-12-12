set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vim plugins expect a POSIX-compliant shell
if &shell !~ '/sh$'
    set shell=/bin/sh
endif

Plugin 'ElmCast/elm-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'airblade/vim-gitgutter'
Plugin 'cfdrake/vim-carthage'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dag/vim-fish'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'garbas/vim-snipmate'
Plugin 'gmarik/Vundle.vim'
Plugin 'hecal3/vim-leader-guide'
Plugin 'honza/vim-snippets'
Plugin 'jerrymarino/SwiftPlayground.vim'
Plugin 'jimmay5469/vim-spacemacs'
Plugin 'jnurmine/Zenburn'
Plugin 'junegunn/fzf.vim'
Plugin 'keith/investigate.vim'
Plugin 'keithbsmiley/swift.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'shemerey/vim-peepopen'
Plugin 'szw/vim-maximizer'
Plugin 'thirtythreeforty/lessspace.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-syntastic/syntastic'

let g:ctrlp_map = '<leader>fp'
let g:rust_recommended_style = 1

call vundle#end()
filetype plugin indent on

" ==============================
" Settings
" ==============================

" Autocompletion
set wildignore+=*.o,*.obj,*.pyc,*.DS_Store,*.db,*.git

if exists('+wildignorecase')
    set wildignorecase
endif

" Backup
set nobackup
set noswapfile
set nowritebackup
set undodir=/tmp
set undofile

" Buffers
set hidden

" Display
set cursorline
set rulerformat=%l:%c
set shortmess=atI
set showcmd
set titlestring=%f title

" Editing
set nofoldenable
set pastetoggle=<f2>
set shiftwidth=4
set tabstop=4
set mouse=a

" Search
set gdefault
set hlsearch
set ignorecase
set smartcase

" Mac options
if has('mac')
    function! s:PBCopy()
        let old = @"
        normal! gvy
        call system('pbcopy', @")
        let @" = old
    endfunction

    vnoremap <silent> Y :<c-u>call<SID>PBCopy()<cr>
endif

" GUI options
if has('gui_running')
    set columns=101 lines=38 " Default window size
    set guicursor=a:blinkon0 " Disable blinking cursor
    set guifont=Menlo\ Regular:h16
    set guioptions=hae
endif

if has('gui_macvim')
    set macmeta
endif

silent! colorscheme zenburn

" Syntax
if !&diff
    syntax on
endif

highlight Normal ctermbg=black guibg=#1a1d1e

" ==============================
" Macros
" ==============================

" Typos
iabbrev !+ !=
iabbrev ~? ~/

" Escape with fd
cnoremap fd <c-c>
inoremap fd <esc>
vnoremap fd <esc>

" Enter cmdline mode with ;
noremap ; :
noremap \ ;

" Paste yanked text (as opposed to cut text)
noremap gp "0p
noremap gP "0P

" Make Y to y as D is to d and C is to c
nnoremap Y y$

let mapleader = "\<space>"
nnoremap <c-w>D :lcd %:p:h<cr>
nnoremap j gj
nnoremap k gk

" Shortcut for switching to/from header files.
function! s:AlternateFile(...)
    for extension in a:000
        let path = expand('%:p:r').'.'.extension
        if filereadable(path) || bufexists(path)
            execute 'e'.fnameescape(path)
            return
        endif
    endfor

    echohl ErrorMsg
    let ext = (a:0 > 1) ? '{'.join(a:000, ',').'}' : a:1
    echo expand('%:p:r').'.'.ext.' not found.'
    echohl None
endfunction

" * and # should search for selected text when used in visual mode.
function! s:VisualSearch()
    let old = @"
    normal! gvy
    let @/ = '\V'.substitute(escape(@", '\'), '\n', '\\n', 'g')
    let @" = old
endfunction

" Shortcut for mimicking <c-l> from Emacs.
function! s:Redraw()
    let ln = line('.')
    let top = line('w0')
    let bottom = line('w$')
    let middle = top + (bottom - top) / 2
    if ln == middle
        normal! zt
    elseif ln == top
        normal! zb
    else
        normal! zz
    end
endfunction

" Shortcut for mimicking <c-k> from Emacs.
function! s:KillLine()
    let [before, after] = s:SplitLineTextAtCursor()
    if len(after) == 0
        normal! J
    else
        call setline(line('.'), before)
    endif
    return ''
endfunction

function! s:SplitLineTextAtCursor()
    let text = getline(line('.'))
    let before = (col('.') > 1) ? text[: col('.') - 2] : ''
    let after  = text[col('.') - 1 :]
    return [before, after]
endfunction

nnoremap <silent> <c-l> :call<SID>Redraw()<cr>
xnoremap * :<c-u>call<SID>VisualSearch()<cr>/<cr>
xnoremap # :<c-u>call<SID>VisualSearch()<cr>?<cr>

noremap <c-a> <home>
noremap <c-e> <end>
noremap + <c-a>
noremap - <c-x>
cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>
cnoremap <c-g> <c-c>

" Emacs bindings in insert mode
inoremap <c-/> <c-o>u
inoremap <c-k> <c-o>:call<SID>KillLine()<cr>
inoremap <c-l> <c-o>:call<SID>Redraw()<cr>
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<c-o>j'
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<c-o>k'

" Spacemacs bindings
let g:spacemacs#excludes = [
  \ '^ff',
\ ]
nnoremap <leader>ff :lcd %:p:h<cr>:e<space>
nnoremap <leader><leader> :

" Terminal registers <c-/> as <c-_> https://stackoverflow.com/a/9051932
imap <c-_> <c-/>

" Visual mode
xnoremap v <esc>
xmap s S

" ==============================
" Autocommands
" ==============================

augroup rccommands
autocmd!

autocmd BufRead,BufNewFile *.h,*.m set filetype=objc
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown

autocmd BufRead,BufNewFile *.h nnoremap <buffer> <silent> <leader>fa :call<SID>AlternateFile('c', 'm', 'cpp', 'cc')<cr>
autocmd BufRead,BufNewFile *.{c\|m\|mm\|cpp\|cc} nnoremap <buffer> <silent> <leader>fa :call<SID>AlternateFile('h')<cr>
autocmd FileType c,cpp,objc,rust inoremap <buffer> <silent> ;$ <c-o>$;
autocmd FileType c,cpp,objc,rust inoremap <buffer> ;; ;
autocmd FileType css,html,objc setlocal nowrap
autocmd FileType elm,haskell,fish,html,javascript,objc,rust,sh,swift,typescript,vim setlocal softtabstop=4
autocmd FileType elm,fish,haskell,html,javascript,objc,pyrex,python,ruby,sh,swift,typescript,vim setlocal expandtab
autocmd FileType elm,fish,haskell,python,pyrex,ruby,sh,scheme setlocal textwidth=80 colorcolumn=81
autocmd FileType help,vim let&l:keywordprg=':help'
autocmd FileType javascript,rust,typescript setlocal textwidth=100 colorcolumn=101
autocmd FileType javascript,typescript setlocal indentexpr=cindent
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType swift setlocal textwidth=120 colorcolumn=121

augroup END
