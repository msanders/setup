" #
" # A minimal .vimrc with saner defaults and some basic Spacemacs bindings.
" #

" Vim plugins expect a POSIX-compliant shell.
set shell=/bin/sh

" Disable netrw.
let g:loaded_netrwPlugin = 1
let g:loaded_netrw = 1

" Workaround for slow performance when loading Python files in Neovim.
if has('mac')
    let g:python_host_prog='/usr/bin/python'
    let g:python3_host_prog='/Applications/Xcode.app/Contents/Developer/usr/bin/python3'
end

call plug#begin()

" ##
" ## Languages
" ##
Plug 'ElmCast/elm-vim'
Plug 'dag/vim-fish'
Plug 'editorconfig/editorconfig-vim'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'

" ### Spacemacs
Plug 'jimmay5469/vim-spacemacs'
Plug 'szw/vim-maximizer'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'easymotion/vim-easymotion'

" ### Theme
Plug 'jnurmine/Zenburn'

" ### tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

" ##
" ## Options
" ##

" ## Autocompletion
set wildignore+=*.o,*.obj,*.pyc,*.DS_Store,*.db,*.git
set wildmode=longest,list

if exists('+wildignorecase')
    set wildignorecase
endif

" ### Backup
set noswapfile
set nobackup
set undofile

if has('nvim')
    " Turn on live search & replace.
    set inccommand=nosplit
else
    " Neovim has a better default undo directory, so prefer that.
    if exists('$XDG_DATA_DIR')
        set undodir=$XDG_DATA_DIR/vim/undo
    else
        set undodir=$HOME/.local/share/vim/undo
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p')
    end
end

" ### Buffers
set hidden

" ### Display
set cursorline
set rulerformat=%l:%c
set shortmess=aI
set showcmd
set titlestring=%f title

" ### Editing
set mouse=a
set nofoldenable
set pastetoggle=<f2>

" Expand tabs to 4 spaces by default.
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Default text wrap / column indicator.
set textwidth=79
set colorcolumn=80

" Automatically use system keyboard.
if has('clipboard')
    set clipboard^=unnamed,unnamedplus
endif

" ### Search
set gdefault
set hlsearch
set ignorecase
set smartcase

" ### Syntax
silent! colorscheme zenburn

" Increase contrast.
highlight Normal ctermbg=235
highlight ColorColumn ctermbg=238
highlight CursorLine cterm=none ctermbg=238
highlight Visual cterm=none ctermbg=241
highlight VisualNOC cterm=none ctermbg=241

" ### Plugin Options

" Disable default EasyMotion mappings.
let g:EasyMotion_do_mapping = 0

" Narrow down supported Spacemacs plugins.
let g:spacemacs#plugins = [
    \ 'easymotion/vim-easymotion',
    \ 'szw/vim-maximizer',
    \ 'tpope/vim-commentary',
    \ 'tpope/vim-fugitive',
\ ]

" Syntastic is quite slow for Rust, so turn it off.
let g:syntastic_rust_checkers = []

" ##
" ## Macros
" ##

" Typos.
iabbrev !+ !=
iabbrev ~? ~/

" Escape with fd.
cnoremap fd <c-c>
inoremap fd <esc>
vnoremap fd <esc>

" Enter cmdline mode with ;
noremap ; :
noremap \ ;

" Paste yanked text (as opposed to cut text).
noremap gp "0p
noremap gP "0P

" Make Y to y as D is to d and C is to c.
nmap Y y$

let mapleader = "\<space>"

" Navigate within wrapped lines by default.
nnoremap j gj
nnoremap k gk

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Shortcut for switching to/from header files.
function! s:AlternateFile(...)
    for extension in a:000
        let path = printf('%s.%s', expand('%:p:r'), extension)
        if filereadable(path) || bufexists(path)
            execute 'e'.fnameescape(path)
            return
        endif
    endfor

    echohl ErrorMsg
    let ext = (a:0 > 1) ? printf('{%s}', join(a:000, ',')) : a:1
    echo printf('%s.%s not found.', expand('%:p:r'), ext)
    echohl None
endfunction

" Bail out when editing a directory.
function! s:DirectoryBailout()
    for file in argv()
        if isdirectory(file)
            try
                " Vim automatically warns about the directory before this is
                " invoked, so just prompt to exit.
                redraw
                call confirm('Exit?', '&OK')
            finally
                " CTRL-C interrupts are caught via try/finally block.
                exit 1
            endtry
        endif
    endfor
endfunction

" Shortcut for mimicking <c-k> from Emacs.
function! s:KillLine()
    let text = getline(line('.'))
    let before = (col('.') > 1) ? text[: col('.') - 2] : ''
    let after  = text[col('.') - 1 :]
    if len(after) == 0
        normal! J
    else
        call setline(line('.'), before)
    endif
    return ''
endfunction

" * and ## should search for selected text when used in visual mode.
function! s:VisualSearch()
    let old = @"
    normal! gvy
    let @/ = '\V'.substitute(escape(@", '\'), '\n', '\\n', 'g')
    let @" = old
endfunction

" Map * and # in visual mode.
xnoremap * :<c-u>call<SID>VisualSearch()<cr>/<cr>
xnoremap # :<c-u>call<SID>VisualSearch()<cr>?<cr>

" Use +/- for incrementing/decrementing numbers.
noremap + <c-a>
noremap - <c-x>

" ### Emacs bindings
cnoremap <c-g> <c-c>
cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>
inoremap <c-k> <c-o>:call<SID>KillLine()<cr>
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<c-o>j'
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<c-o>k'
nnoremap <leader><leader> :
nnoremap <leader>ff :lcd %:p:h<cr>:e<space>
noremap <c-a> <home>
noremap <c-e> <end>

" ### Visual mode
xnoremap v <esc>
xmap s S

" ##
" ## Autocommands
" ##
augroup rccommands
autocmd!

autocmd BufRead,BufNewFile *.h nnoremap <buffer> <silent> <leader>fa :call<sid>AlternateFile('c', 'm', 'cpp', 'cc')<cr>
autocmd BufRead,BufNewFile *.h,*.m set filetype=objc
autocmd BufRead,BufNewFile *.{c,m,mm,cpp,cc} nnoremap <buffer> <silent> <leader>fa :call<sid>AlternateFile('h')<cr>
autocmd BufRead,BufNewFile Brewfile,Brewfile.* setlocal filetype=ruby
autocmd FileType gitconfig,make setlocal noexpandtab
autocmd FileType fish,javascript,rust,swift,typescript setlocal textwidth=100 colorcolumn=101
autocmd FileType ruby,yaml setlocal tabstop=2 shiftwidth=2
autocmd VimEnter * call s:DirectoryBailout()

augroup END
