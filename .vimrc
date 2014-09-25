call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

let mapleader = ","

" Command-T mappings
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR> noremap <leader>m <Esc>:CommandTBuffer<CR>
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'


filetype plugin on
filetype indent on

let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" Solarized color scheme
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', '\.o$']

" Make the command line two lines high and change the statusline display to
" something that looks useful.
set cmdheight=2
set laststatus=2
set statusline=[%l,%v\ %P%M][CWD:\ %{CWD()}][FILE:\ %f]\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}\ %#warningmsg#%{SyntasticStatuslineFlag()}%* 
set showcmd 
set showmode
set number

function! CWD()
    let curdir = substitute(getcwd(), '/home/danw', "~/", "g")
    return curdir
endfunction

set ignorecase
" /foo matches foo and fOo, but /FOO only matches FOO
set smartcase

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" turn off smartindent for python (so # doesn't go to the beginning of the line)
au! FileType python setl nosmartindent

au! FileType jade setl sw=2 ts=2 sts=2
au! FileType coffee setl sw=2 ts=2 sts=2

" close quickfix window when I close a file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Shortcuts for navigating (tj, tk) and creating (<F6>, ',n') tabs
noremap tj :tabp<CR>
noremap tk :tabn<CR>
noremap <F6> :tabe 
noremap <Leader>n :tabe <C-R>=expand("%:p:h") . "/" <CR>


" Paste over selection without replacing contents of register
" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

" look for modeline in first 100 lines of files (e.g. for python files
" with 2 character indentation)
set modelines=100

" go up/down by one on-screen line
nmap j gj
nmap k gk

" highlight matches as I type
set incsearch

" Quickfix - next/prev error
noremap <leader>e <Esc>:cn<CR>
noremap <leader>E <Esc>:cN<CR>

" No python folding
let g:pymode_folding = 0

" No beeping
set visualbell           " don't beep
set noerrorbells

" github flavored markedown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

let &t_Co=256

autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
